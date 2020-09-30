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

import android.view.View
import android.view.ViewGroup
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.android.action.Action
import br.com.zup.beagle.android.context.Bind
import br.com.zup.beagle.android.context.ContextComponent
import br.com.zup.beagle.android.context.ContextData
import br.com.zup.beagle.android.context.normalizeContextValue
import br.com.zup.beagle.android.data.serializer.BeagleSerializer
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.utils.getContextData
import br.com.zup.beagle.android.utils.observeBindChanges
import br.com.zup.beagle.android.utils.safeGet
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
    private lateinit var contextAdapter: ListViewContextAdapterTwo

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

        setupRecyclerView(recyclerView, rootView, template, orientation)
        configDataSourceObserver(rootView, recyclerView)
        configRecyclerViewScrollListener(recyclerView, rootView)
        handleOnInit()

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
        contextAdapter = ListViewContextAdapterTwo(template, iteratorName, key, viewFactory, orientation, rootView)
//        contextAdapter.setHasStableIds(true)
        recyclerView.apply {
            adapter = contextAdapter
            layoutManager = LinearLayoutManager(context, orientation, false).apply {
//                recycleChildrenOnDetach = true
            }
        }
    }

    private fun configDataSourceObserver(rootView: RootView, recyclerView: RecyclerView) {
        observeBindChanges(rootView, recyclerView, dataSource) { value ->
            if (value != list) {
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

internal class ListViewContextAdapterTwo(
    template: ServerDrivenComponent,
    val iteratorName: String,
    val key: String? = null,
    val viewFactory: ViewFactory,
    val orientation: Int,
    val rootView: RootView
) : RecyclerView.Adapter<ContextViewHolderTwo>() {

    // ViewModels to manage ids and contexts
    private val viewModel = rootView.generateViewModelInstance<ScreenContextViewModel>()
    private val generateIdViewModel = rootView.generateViewModelInstance<GenerateIdViewModel>()

//    var info = MutableList<Any>()

    // Serializer to provide new template instances
    private val serializer = BeagleSerializer()

    // Struct that holds all data of each item
    private var adapterItems = listOf<BeagleAdapterItem>()

    // Shared created views between nested recyclers
    private val viewPool = RecyclerView.RecycledViewPool()

    // ViewHolders who called onInit but did not finish
    private val onInitiableWidgetsOnHolders = mutableMapOf<ContextViewHolderTwo, MutableList<OnInitiableWidget>>()

    // Quick access to the holders of the views that are OnInitiableWidgets
    private val holderToInitiableWidgets = mutableMapOf<OnInitiableWidget, ContextViewHolderTwo>()

    // Struct to manage ViewHolders not recycled
    private val recycledViewHolders = mutableListOf<ContextViewHolderTwo>()

    // Each access generate a new instance of the template to avoid reference conflict
    private val templateJson = serializer.serializeComponent(template)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContextViewHolderTwo {
        val newTemplate = serializer.deserializeComponent(templateJson)
        val view = generateView(newTemplate)
        return ContextViewHolderTwo(
            view,
            newTemplate,
            serializer,
            viewModel,
            generateIdViewModel,
            rootView,
            templateJson,
            iteratorName
        )
    }

    private fun generateView(newTemplate: ServerDrivenComponent) = viewFactory.makeBeagleFlexView(
        rootView,
        Style(flex = Flex(flexDirection = flexDirection()))
    ).apply {
        layoutParams = RecyclerView.LayoutParams(layoutParamWidth(), layoutParamHeight())
        addServerDrivenComponent(newTemplate)
    }

    private fun layoutParamWidth() = if (isOrientationVertical()) MATCH_PARENT else WRAP_CONTENT

    private fun layoutParamHeight() = if (isOrientationVertical()) WRAP_CONTENT else MATCH_PARENT

    private fun flexDirection() = if (isOrientationVertical()) FlexDirection.COLUMN else FlexDirection.ROW

    private fun isOrientationVertical() = (orientation == RecyclerView.VERTICAL)

    override fun onBindViewHolder(holder: ContextViewHolderTwo, position: Int) {
        val listId = getListIdByKey(position)
        val isRecycled = recycledViewHolders.contains(holder)
        // Handle context, ids and direct nested adapters
        holder.onBind(listId, adapterItems[position], isRecycled)
        // Handle widgets with onInit
        if (!adapterItems[position].completelyInitialized) {
            handleInitiableWidgets(holder, isRecycled)
        }
    }

    private fun getListIdByKey(position: Int): String {
        val listId = key?.let { ((adapterItems[position].data) as JSONObject).safeGet(it) } ?: position
        return listId.toString()
    }

    private fun handleInitiableWidgets(holder: ContextViewHolderTwo, shouldRerunOnInit: Boolean = false) {
        // For each OnInitiableWidget
        holder.initiableWidgets.forEach { widget ->
            // Links the widget to its respective holder
            holderToInitiableWidgets[widget] = holder
            // Add widget to list of widgets with onInit running
            if (!onInitiableWidgetsOnHolders.containsKey(holder)) {
                onInitiableWidgetsOnHolders[holder] = mutableListOf()
            }
            onInitiableWidgetsOnHolders[holder]?.add(widget)
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
            // When the view is recycled we must call onInit again
            if (shouldRerunOnInit) {
                widget.executeOnInit()
            }
        }
    }

    private fun resolveWidgetFinishedOnInit(widget: OnInitiableWidget) {
        val holder = holderToInitiableWidgets[widget]
        holder?.let {
            onInitiableWidgetsOnHolders[it]?.remove(widget)
            manageHolderCompletelyInitializedStatus(it)
        }
    }

    private fun manageHolderCompletelyInitializedStatus(holder: ContextViewHolderTwo) {
        val isHolderCompletelyInitialized = onInitiableWidgetsOnHolders[holder]?.isEmpty() ?: true
        if (isHolderCompletelyInitialized) {
            if (!holder.isRecyclable) {
                holder.setIsRecyclable(true)
            }
            adapterItems[holder.adapterPosition].completelyInitialized = true
        }
    }

    override fun onViewRecycled(holder: ContextViewHolderTwo) {
        super.onViewRecycled(holder)
        recycledViewHolders.add(holder)
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
        clearAdapterContent()
        adapterItems = list.map { BeagleAdapterItem(data = it.normalizeContextValue()) }
        notifyDataSetChanged()
    }

    fun clearList() {
        val initialSize = adapterItems.size
        clearAdapterContent()
        notifyItemRangeRemoved(0, initialSize)
    }

    private fun clearAdapterContent() {
        adapterItems = emptyList()
        onInitiableWidgetsOnHolders.clear()
        holderToInitiableWidgets.clear()
        recycledViewHolders.clear()
    }

    override fun getItemCount() = adapterItems.size
}

internal class ContextViewHolderTwo(
    itemView: View,
    private val template: ServerDrivenComponent,
    private val serializer: BeagleSerializer,
    private val viewModel: ScreenContextViewModel,
    private val generateIdViewModel: GenerateIdViewModel,
    private val rootView: RootView,
    private val jsonTemplate: String,
    private val iteratorName: String
) : RecyclerView.ViewHolder(itemView) {

    private val viewsWithId = mutableMapOf<String, View>()
    private val viewsWithContext = mutableListOf<View>()
    private val directNestedRecyclers = mutableListOf<RecyclerView>()
    private val contextComponents = mutableListOf<ContextData>()
    val initiableWidgets = mutableListOf<OnInitiableWidget>()

    init {
        initializeViewsWithId(template)
        initializeViewsWithContextAndRecyclers(itemView)
    }

    private fun initializeViewsWithId(component: ServerDrivenComponent) {
        (component as? IdentifierComponent)?.let {
            component.id?.let { id ->
                viewsWithId.put(id, itemView.findViewById<View>(id.toAndroidId()))
            }
        }
        if (component is SingleChildComponent) {
            initializeViewsWithId(component.child)
        } else if (component is MultiChildComponent) {
            component.children.forEach { child ->
                initializeViewsWithId(child)
            }
        }
    }

    private fun initializeViewsWithContextAndRecyclers(view: View) {
        if (view.getContextData() != null) {
            viewsWithContext.add(view)
        }
        if (view !is ViewGroup) {
            return
        } else if (view is RecyclerView) {
            directNestedRecyclers.add(view)
            return
        }
        val count = view.childCount
        for (i in 0 until count) {
            val child = view.getChildAt(i)
            initializeViewsWithContextAndRecyclers(child)
        }
    }

    // For each item on the list
    fun onBind(listId: String, beagleAdapterItem: BeagleAdapterItem, isRecycled: Boolean) {
        // Clear references to components
        clearHolderComponents()
        // We check if its holder has been recycled and update its references
        val newTemplate = if (isRecycled) {
            serializer.deserializeComponent(jsonTemplate)
        } else {
            template
        }
        // Using a new template reference we populate the components with id and context
        initializeComponents(newTemplate)
        // Checks whether views with ids and context have been updated based on the key and updates or restore them
        if (beagleAdapterItem.firstTimeBinding) {
            // Since the context needs unique id references for each view, we update them here
            updateIdToEachSubView(listId, beagleAdapterItem)
            // If the holder is being recycled
            if (isRecycled) {
                // We set the template's default contexts for each view with context
                setDefaultContextToEachContextView()
                // For each RecyclerView nested directly when recycled, we generate a new adapter
                generateAdapterToEachDirectNestedRecycler(newTemplate, beagleAdapterItem)
            } else {
                // When this item is not recycled, we simply recover your current adapters
                useCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem)
            }
        } else {
            // But if that item on the list already has ids created, we retrieve them
            restoreIds(beagleAdapterItem)
            // We also recover the contexts of all previously created views with context
            restoreContexts()
            // Recovers adapters previously created for the RecyclerViews of this cell
            restoreAdapters(beagleAdapterItem)
        }
        // Finally, we updated the context of that cell effectively.
        setContext(iteratorName, beagleAdapterItem)
        // Mark this position on the list as finished
        beagleAdapterItem.firstTimeBinding = false
    }

    private fun clearHolderComponents() {
        initiableWidgets.clear()
        contextComponents.clear()
    }

    private fun initializeComponents(component: ServerDrivenComponent) {
        (component as? OnInitiableWidget)?.let {
            component.onInit?.let {
                initiableWidgets.add(component)
            }
        }
        (component as? ContextComponent)?.let {
            component.context?.let {
                contextComponents.add(it)
            }
        }
        if (component is SingleChildComponent) {
            initializeComponents(component.child)
        } else if (component is MultiChildComponent) {
            component.children.forEach { child ->
                initializeComponents(child)
            }
        }
    }

    private fun updateIdToEachSubView(listId: String, beagleAdapterItem: BeagleAdapterItem) {
        val itemViewId = View.generateViewId()
        itemView.id = itemViewId
        beagleAdapterItem.viewIds[itemView] = itemViewId

        viewsWithId.forEach { (id, view) ->
            val identifierViewId = "$id:$listId".toAndroidId()
            view.id = identifierViewId
            beagleAdapterItem.viewIds[view] = identifierViewId
        }

        val viewsWithContextAndWithoutId = viewsWithContext.filterNot { viewsWithId.containsValue(it) }
        viewsWithContextAndWithoutId.forEach {
            val subViewId = try {
                generateIdViewModel.getViewId(rootView.getParentId())
            } catch (exception: Exception) {
                View.generateViewId()
            }
            it.id = subViewId
            beagleAdapterItem.viewIds[it] = subViewId
        }
    }

    private fun setDefaultContextToEachContextView() {
        viewsWithContext.forEach { view ->
            val savedContext = contextComponents.firstOrNull { it.id == view.getContextData()?.id }
            savedContext?.let { context ->
                viewModel.addContext(view, context, shouldOverrideExistingContext = true)
            }
        }
    }

    private fun generateAdapterToEachDirectNestedRecycler(
        newTemplate: ServerDrivenComponent,
        beagleAdapterItem: BeagleAdapterItem
    ) {
        directNestedRecyclers.forEach {
            val oldAdapter = it.adapter as ListViewContextAdapterTwo
            val updatedAdapter = ListViewContextAdapterTwo(
                newTemplate,
                oldAdapter.iteratorName,
                oldAdapter.key,
                oldAdapter.viewFactory,
                oldAdapter.orientation,
                oldAdapter.rootView
            )
//            it.adapter = updatedAdapter
            beagleAdapterItem.directNestedAdapters[it] = updatedAdapter
        }
    }

    private fun useCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
            beagleAdapterItem.directNestedAdapters[it] = it.adapter as ListViewContextAdapterTwo
        }
    }

    private fun restoreIds(beagleAdapterItem: BeagleAdapterItem) {
        beagleAdapterItem.viewIds[itemView]?.let { savedId ->
            itemView.id = savedId
        }
        viewsWithContext.forEach { viewWithContext ->
            beagleAdapterItem.viewIds[viewWithContext]?.let { savedId ->
                viewWithContext.id = savedId
            }
        }
        viewsWithId.values.forEach { viewWithId ->
            beagleAdapterItem.viewIds[viewWithId]?.let { savedId ->
                viewWithId.id = savedId
            }
        }
    }

    private fun restoreContexts() {
        viewsWithContext.forEach {
            viewModel.restoreContext(it)
        }
    }

    private fun restoreAdapters(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
//            it.adapter = beagleAdapterItem.directNestedAdapters[it]
        }
    }

    private fun setContext(iteratorName: String, beagleAdapterItem: BeagleAdapterItem) {
        viewModel.addContext(
            view = itemView,
            contextData = ContextData(id = iteratorName, value = beagleAdapterItem.data),
            shouldOverrideExistingContext = true
        )
    }
}

internal class BeagleAdapterItem(
    var viewIds: MutableMap<View, Int> = mutableMapOf(),
    val data: Any,
    var completelyInitialized: Boolean = false,
    var firstTimeBinding: Boolean = true,
    val directNestedAdapters: MutableMap<RecyclerView, ListViewContextAdapterTwo> = mutableMapOf()
)
