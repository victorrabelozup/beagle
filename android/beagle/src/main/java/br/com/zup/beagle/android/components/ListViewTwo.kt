/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.android.components

import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT
import androidx.annotation.IdRes
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.android.action.Action
import br.com.zup.beagle.android.context.Bind
import br.com.zup.beagle.android.context.ContextComponent
import br.com.zup.beagle.android.context.ContextData
import br.com.zup.beagle.android.context.normalizeContextValue
import br.com.zup.beagle.android.data.serializer.BeagleMoshi
import br.com.zup.beagle.android.data.serializer.BeagleSerializer
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.utils.getContextData
import br.com.zup.beagle.android.utils.observeBindChanges
import br.com.zup.beagle.android.utils.setContextData
import br.com.zup.beagle.android.utils.toAndroidId
import br.com.zup.beagle.android.view.ViewFactory
import br.com.zup.beagle.android.view.viewmodel.GenerateIdViewModel
import br.com.zup.beagle.android.view.viewmodel.ScreenContextViewModel
import br.com.zup.beagle.android.widget.OnInitFinishedListener
import br.com.zup.beagle.android.widget.OnInitiableWidget
import br.com.zup.beagle.android.widget.RootView
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.core.MultiChildComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.core.SingleChildComponent
import br.com.zup.beagle.core.Style
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.ListDirection
import org.json.JSONObject
import java.lang.Exception

@RegisterWidget
data class ListView(
    val direction: ListDirection,
    override val context: ContextData? = null,
    override val onInit: List<Action>? = null,
    val dataSource: Bind<List<Any>>,
    val template: ServerDrivenComponent,
    val onScrollEnd: List<Action>? = null,
    val scrollThreshold: Int? = null,
    val iteratorName: String = "item",
    val key: String? = null
) : OnInitiableWidget(), ContextComponent {

    @Transient
    private val viewFactory: ViewFactory = ViewFactory()

    @Transient
    private lateinit var contextAdapter: ListViewContextAdapter2

    @Transient
    private var list: List<Any>? = null

    @Transient
    private var canScrollEnd = true

    @Transient
    private lateinit var recyclerView: RecyclerView

    @Transient
    private lateinit var rootView: RootView

    override fun getView() = recyclerView

    override fun getRootView() = rootView

    override fun buildView(rootView: RootView): View {
        this.rootView = rootView
        val orientation = listDirectionToRecyclerViewOrientation()
        recyclerView = viewFactory.makeRecyclerView(rootView.getContext())

        handleOnInit()
        setupRecyclerView(recyclerView, rootView, template, orientation)
        configDataSourceObserver(rootView, recyclerView)
        configRecyclerViewScrollListener(recyclerView, rootView)

        return recyclerView
    }

    private fun listDirectionToRecyclerViewOrientation() = if (direction == ListDirection.VERTICAL) {
        RecyclerView.VERTICAL
    } else {
        RecyclerView.HORIZONTAL
    }

    private fun setupRecyclerView(
        recyclerView: RecyclerView,
        rootView: RootView,
        template: ServerDrivenComponent,
        orientation: Int
    ) {
        contextAdapter = ListViewContextAdapter2(template, iteratorName, key, viewFactory, orientation, rootView)
        recyclerView.apply {
            adapter = contextAdapter
            layoutManager = LinearLayoutManager(context, orientation, false)
        }
    }

    private fun configDataSourceObserver(rootView: RootView, recyclerView: RecyclerView) {
        observeBindChanges(rootView, recyclerView, dataSource) { value ->
            if (value !== list) {
                if (value.isNullOrEmpty()) {
                    contextAdapter.clearList()
                    executeScrollEnd(recyclerView, rootView) //TODO test when list is empty
                } else {
                    contextAdapter.setList(value)
                }
                list = value
                canScrollEnd = true
            }
        }
    }

    private fun configRecyclerViewScrollListener(
        recyclerView: RecyclerView,
        rootView: RootView
    ) {
        recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                executeScrollEnd(recyclerView, rootView)
            }
        })
    }

    private fun executeScrollEnd(recyclerView: RecyclerView, rootView: RootView) {
        onScrollEnd?.let {
            if (canCallOnScrollEnd(recyclerView)) {
                it.forEach { action ->
                    action.execute(rootView, recyclerView)
                }
                canScrollEnd = false
            }
        }
    }

    private fun canCallOnScrollEnd(recyclerView: RecyclerView): Boolean {
        val reachEnd = scrollThreshold?.let {
            val scrolledPercent = calculateScrolledPercent(recyclerView)
            scrolledPercent >= scrollThreshold
        } ?: !run {
            if (direction == ListDirection.VERTICAL) {
                recyclerView.canScrollVertically(1)
            } else {
                recyclerView.canScrollHorizontally(1)
            }
        }
        return reachEnd && canScrollEnd
    }

    private fun calculateScrolledPercent(recyclerView: RecyclerView): Float {
        var scrolledPercentage: Float
        (recyclerView.layoutManager as LinearLayoutManager).apply {
            val totalItemCount = itemCount
            val lastVisible = findLastVisibleItemPosition().toFloat()
            scrolledPercentage = (lastVisible / totalItemCount) * 100
        }
        return scrolledPercentage
    }
}

internal class ListViewContextAdapter2(
    template: ServerDrivenComponent,
    private val iteratorName: String,
    private val key: String? = null,
    private val viewFactory: ViewFactory,
    private val orientation: Int,
    private val rootView: RootView
) : RecyclerView.Adapter<ContextViewHolderTwo>() {

    private val viewModel = rootView.generateViewModelInstance<ScreenContextViewModel>()

    // Struct that holds all data of each item
    private var adapterItems = listOf<BeagleAdapterItem>()

    // Shared created views between nested recyclers
    private val viewPool = RecyclerView.RecycledViewPool()

    // ViewHolders who called onInit but did not finish
    private val onInitControl = mutableMapOf<ContextViewHolderTwo, MutableList<OnInitiableWidget>>()

    // Quick access to the holders of the views that are OnInitiableWidgets
    private val initiableWidgetsMap = mutableMapOf<OnInitiableWidget, ContextViewHolderTwo>()

    // Struct to manage ViewHolders not recycled
    private val createdViewHolderList = mutableListOf<ContextViewHolderTwo>()

    // Each access generate a new instance of the template to avoid reference conflict
    private val templateJson = BeagleSerializer().serializeComponent(template)

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): ContextViewHolderTwo {
        val newTemplate = BeagleSerializer().deserializeComponent(templateJson)
        val view = generateView(newTemplate)
        val holder = ContextViewHolderTwo(view, newTemplate, viewModel)
        handleInitiableWidgets(holder)
        // Adds a list of newly created but not yet recycled holders
        createdViewHolderList.add(holder)
        return holder
    }

    private fun generateView(newTemplate: ServerDrivenComponent) = viewFactory.makeBeagleFlexView(
        rootView,
        Style(flex = Flex(flexDirection = flexDirection()))
    ).apply {
        layoutParams = RecyclerView.LayoutParams(layoutParamWidth(), layoutParamHeight())
        addServerDrivenComponent(newTemplate) // ele nao faz
        //optimizeDirectNestedRecyclerViews(this)
    }

    private fun layoutParamWidth() = if (isOrientationVertical()) MATCH_PARENT else WRAP_CONTENT

    private fun layoutParamHeight() = if (isOrientationVertical()) WRAP_CONTENT else MATCH_PARENT

    private fun flexDirection() = if (isOrientationVertical()) FlexDirection.COLUMN else FlexDirection.ROW

    private fun isOrientationVertical() = (orientation == RecyclerView.VERTICAL)

    private fun optimizeDirectNestedRecyclerViews(view: View) {
        val recyclerViewList = mutableListOf<RecyclerView>()
        findDirectNestedRecyclerViews(view, recyclerViewList)
        recyclerViewList.forEach {
            it.setRecycledViewPool(viewPool)
        }
    }

    private fun findDirectNestedRecyclerViews(view: View, recyclerList: MutableList<RecyclerView>) {
        if (view !is ViewGroup) {
            return
        }
        if (view is RecyclerView) {
            recyclerList.add(view)
            return
        }
        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            findDirectNestedRecyclerViews(child, recyclerList)
        }
    }

    private fun handleInitiableWidgets(holder: ContextViewHolderTwo, isRecycling: Boolean = false) {
        // For each OnInitiableWidget
        holder.initiableWidgets.forEach { widget ->
            // Links the widget to its respective holder
            initiableWidgetsMap[widget] = holder
            // Add widget to list of widgets with onInit running
            if (!onInitControl.containsKey(holder)) {
                onInitControl[holder] = mutableListOf()
            }
            onInitControl[holder]?.add(widget)
            // Marks holders with onInit not to be recycled until they are finished
            if (holder.isRecyclable) {
                holder.setIsRecyclable(false)
            }
            // Add listener to capture when onInit is finished
            widget.setOnInitFinishedListener(object : OnInitFinishedListener {
                override fun invoke(widget: OnInitiableWidget) {
                    resolveWidgetFinishedOnInit(widget)
                }
            })

            if (isRecycling) {
                widget.executeOnInit()
            }
        }
    }

    private fun resolveWidgetFinishedOnInit(widget: OnInitiableWidget) {
        val holder = initiableWidgetsMap[widget]
        holder?.let {
            onInitControl[it]?.remove(widget)
            manageHolderCompletelyInitializedStatus(it)
        }
    }

    private fun manageHolderCompletelyInitializedStatus(holder: ContextViewHolderTwo) {
        val isHolderCompletelyInitialized = onInitControl[holder]?.isEmpty() ?: true
        if (isHolderCompletelyInitialized) {
            if (!holder.isRecyclable) {
                holder.setIsRecyclable(true)
            }
            adapterItems[holder.adapterPosition].completelyInitialized = true
        }
    }

    override fun onBindViewHolder(holder: ContextViewHolderTwo, position: Int) {
        // Update context and ids
        holder.onBind(iteratorName, getListIdByKey(position), adapterItems[position], !createdViewHolderList.contains(holder), rootView, templateJson)
        // Only if the ViewHolder has already been recycled do we validate onInit again.
        if (!createdViewHolderList.contains(holder)) {
            // Treat widgets with onInit
            if (!adapterItems[position].completelyInitialized) {
                handleInitiableWidgets(holder, true)
            }
        } else {
            // Remove holder from newly created and not recycled holders list
            createdViewHolderList.remove(holder)
        }
    }

    private fun getListIdByKey(position: Int): String {
        val listId = key?.let { ((adapterItems[position].data) as JSONObject).get(it) } ?: position
        return listId.toString()
    }

    override fun onViewAttachedToWindow(holder: ContextViewHolderTwo) {
        super.onViewAttachedToWindow(holder)

        // For every view, the moment it is displayed, its completely initialized status is checked and updated.
        // This validation must be done here to cover the cases where onInit is executed before the item is visible.
        if (!adapterItems[holder.adapterPosition].completelyInitialized) {
            manageHolderCompletelyInitializedStatus(holder)
        }
    }

    fun setList(list: List<Any>) {
        adapterItems = list.map { BeagleAdapterItem(id = View.generateViewId(), data = it.normalizeContextValue()) }
        notifyDataSetChanged()
    }

    fun clearList() {
        val initialSize = adapterItems.size
        adapterItems = emptyList()
        notifyItemRangeRemoved(0, initialSize)
    }

    override fun getItemCount() = adapterItems.size
}

internal class ContextViewHolderTwo(
    itemView: View,
    template: ServerDrivenComponent,
    private val viewModel: ScreenContextViewModel
) : RecyclerView.ViewHolder(itemView) {

    private val viewsWithId = mutableMapOf<String, View>()
    val initiableWidgets = mutableListOf<OnInitiableWidget>()

    init {
        initializeHolder(template)
    }

    private fun initializeHolder(component: ServerDrivenComponent) {
        (component as? IdentifierComponent)?.let {
            component.id?.let { id ->
                viewsWithId.put(id, itemView.findViewById<View>(id.toAndroidId()))
            }
        }
        (component as? OnInitiableWidget)?.let {
            component.onInit?.let {
                initiableWidgets.add(component)
            }
        }
        if (component is SingleChildComponent) {
            initializeHolder(component.child)
        } else if (component is MultiChildComponent) {
            component.children.forEach { child ->
                initializeHolder(child)
            }
        }
    }

    fun onBind(iteratorName: String, listId: String, beagleAdapterItem: BeagleAdapterItem, isRecycling: Boolean, rootView: RootView, jsonTemplate: String) {
        Log.wtf("listContext", "onBind ini ${System.identityHashCode(itemView)}")

        setIsRecyclable(false)
        itemView.id = beagleAdapterItem.id
        setContext(iteratorName, beagleAdapterItem)
        updateIdToEachSubView(listId, beagleAdapterItem)

        /**
         * Para cada posição do adapter:
         *
         *  - Se é a primeira vez que está fazendo o bind dessa posição do adapter:
         *
         *      - Atualiza todos os IDs do template (atribui novos ids para as views)
         *      - Seta os contextos default (vai no template e pega uma nova instância do contexto
         *      - Salva os ids das views
         *
         *  - Senão:
         *      - restaura os ids das views
         *      - restaura os contextos das views
         *
         */

        if (isRecycling && !beagleAdapterItem.idsSaved) {
            updateIds(itemView, beagleAdapterItem, rootView)
            addContexts(itemView, jsonTemplate)
        }

        if (!beagleAdapterItem.idsSaved) {
            saveIds(itemView, beagleAdapterItem)
            beagleAdapterItem.idsSaved = true
        } else {
            restoreIds(itemView, beagleAdapterItem)
            restoreContexts(itemView)
        }

        setIsRecyclable(true)

        Log.wtf("listContext", "onBind fim ${System.identityHashCode(itemView)}")
    }

    private fun addContexts(view: View, jsonTemplate: String) {
        val template = BeagleSerializer().deserializeComponent(jsonTemplate)
        val contextList = mutableListOf<ContextData>()
        getContextList(template, contextList)
        updateContexts(view, contextList)
    }

    private fun updateContexts(view: View, contextList: MutableList<ContextData>) {
        if (view.getContextData() != null) {

            contextList.forEach { context ->
                if(context.id == (view.getContextData() as ContextData).id){
                    viewModel.addContext(view, context)
                }
            }
        }

        if (view !is ViewGroup || view is RecyclerView) {
            return
        }

        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            updateContexts(child, contextList)
        }
    }

    private fun getContextList(template: ServerDrivenComponent, contextList: MutableList<ContextData>) {
        if (template is ContextComponent) {
            if (template.context != null) {
                contextList.add(template.context!!)
            }
        }
        if (template is SingleChildComponent) {
            getContextList(template.child, contextList)
        } else if (template is MultiChildComponent) {
            template.children.forEach { child ->
                getContextList(child, contextList)
            }
        }
    }

    private fun restoreContexts(view: View) {
        if (view.getContextData() != null) {
            viewModel.restoreContext(view)
        }

        if (view !is ViewGroup || view is RecyclerView) {
            return
        }

        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            restoreContexts(child)
        }
    }

    private fun updateIds(view: View, beagleAdapterItem: BeagleAdapterItem, rootView: RootView) {

        val generateIdViewModel = rootView.generateViewModelInstance<GenerateIdViewModel>()
        view.id = try {
            generateIdViewModel.getViewId(rootView.getParentId())
        } catch (exception: Exception) {
            View.generateViewId()
        }

        if (view !is ViewGroup || view is RecyclerView) {
            return
        }

        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            updateIds(child, beagleAdapterItem, rootView)
        }
    }

    private fun saveIds(view: View, beagleAdapterItem: BeagleAdapterItem) {

        beagleAdapterItem.childrenIdList.add(view.id)

        if (view !is ViewGroup || view is RecyclerView) {
            return
        }

        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            saveIds(child, beagleAdapterItem)
        }
    }

    data class IdIndex(var index: Int = 0)

    private fun restoreIds(view: View, beagleAdapterItem: BeagleAdapterItem, idIndex: IdIndex = IdIndex()) {


        view.id = beagleAdapterItem.childrenIdList[idIndex.index]
        idIndex.index++

        if (view !is ViewGroup || view is RecyclerView) {
            return
        }

        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            restoreIds(child, beagleAdapterItem, idIndex)
        }
    }

    private fun setContext(iteratorName: String, beagleAdapterItem: BeagleAdapterItem) {
        viewModel.addContext(
            view = itemView,
            contextData = ContextData(id = iteratorName, value = beagleAdapterItem.data),
            shouldOverrideExistingContext = true
        )
    }

    private fun updateIdToEachSubView(listId: String, beagleAdapterItem: BeagleAdapterItem) {
        if (!beagleAdapterItem.idsUpdated) {
            viewsWithId.forEach { (id, view) ->
                view.id = "$id:$listId".toAndroidId()
            }
            beagleAdapterItem.idsUpdated = true
        }
    }
}

internal class BeagleAdapterItem(
    @IdRes val id: Int,
    val data: Any,
    var completelyInitialized: Boolean = false,
    var idsUpdated: Boolean = false,
    val childrenIdList: MutableList<Int> = mutableListOf(),
    var idsSaved: Boolean = false
)
