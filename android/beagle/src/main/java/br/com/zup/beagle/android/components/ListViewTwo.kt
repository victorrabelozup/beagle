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
import android.widget.ImageView
import androidx.core.view.children
import androidx.recyclerview.widget.DiffUtil
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
import br.com.zup.beagle.android.view.viewmodel.ListViewIdViewModel
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
import java.util.*

@RegisterWidget
data class ListView
//TODO: verificar a versão da depreciação
@Deprecated(
    message = "It was deprecated in version x.x and will be removed in a future version. " +
        "Use dataSource and template instead children.",
    replaceWith = ReplaceWith(
        "ListView(direction, context, onInit, dataSource, template, onScrollEnd, scrollThreshold," +
        "iteratorName, key)")
)
constructor(
    val children: List<ServerDrivenComponent>? = null,
    val direction: ListDirection = ListDirection.VERTICAL,
    override val context: ContextData? = null,
    override val onInit: List<Action>? = null,
    val dataSource: Bind<List<Any>>? = null,
    val template: ServerDrivenComponent? = null,
    val onScrollEnd: List<Action>? = null,
    val scrollThreshold: Int? = null,
    val iteratorName: String = "item",
    val key: String? = null
) : OnInitiableWidget(), ContextComponent {

    @Deprecated(message = "It was deprecated in version x.x and will be removed in a future version. " +
        "Use dataSource and template instead children.",
        replaceWith = ReplaceWith(
            "ListView(direction, context, onInit, dataSource, template, onScrollEnd, scrollThreshold," +
                "iteratorName, key)"))
    constructor(
        children: List<ServerDrivenComponent>,
        direction: ListDirection
    ) : this(
        children = children,
        direction = direction,
        context = null,
    )

    constructor(
        direction: ListDirection,
        context: ContextData? = null,
        onInit: List<Action>? = null,
        dataSource: Bind<List<Any>>,
        template: ServerDrivenComponent,
        onScrollEnd: List<Action>? = null,
        scrollThreshold: Int? = null,
        iteratorName: String = "item",
        key: String? = null
    ) : this(
        null,
        direction,
        context,
        onInit,
        dataSource,
        template,
        onScrollEnd,
        scrollThreshold,
        iteratorName,
        key
    )

    @Transient
    private val viewFactory: ViewFactory = ViewFactory()

    @Transient
    private var canScrollEnd = true

    @Transient
    private lateinit var recyclerView: RecyclerView

    @Transient
    private lateinit var rootView: RootView

    @Transient
    private lateinit var listViewIdViewModel: ListViewIdViewModel

    override fun getView() = recyclerView

    override fun getRootView() = rootView

    override fun buildView(rootView: RootView): View {
        this.rootView = rootView

        if (children.isNullOrEmpty()) {
            template?.let {
                dataSource?.let {
                    return buildNewListView()
                }
            }
        }

        return buildOldListView()
    }

    @Deprecated(message = "It was deprecated in version x.x and will be removed in a future version. " +
        "Use new ListView implementation instead.",
        replaceWith = ReplaceWith("buildNewListView()"))
    private fun buildOldListView() : View {
        val recyclerView = viewFactory.makeRecyclerView(rootView.getContext())
        recyclerView.apply {
            val orientation = listDirectionToRecyclerViewOrientation()
            layoutManager = LinearLayoutManager(context, orientation, false)
            this@ListView.children?.let {
                adapter = ListViewRecyclerAdapter(it, viewFactory, orientation, this@ListView.rootView)
            }
        }

        return recyclerView
    }

    private fun buildNewListView() : View {
        listViewIdViewModel = rootView.generateViewModelInstance()
        recyclerView = viewFactory.makeRecyclerView(rootView.getContext())

        val orientation = listDirectionToRecyclerViewOrientation()
        setupRecyclerView(rootView, orientation)
        configDataSourceObserver(rootView)
        configRecyclerViewScrollListener(rootView)
        handleOnInit()

        return recyclerView
    }

    @Deprecated(message = "It was deprecated in version x.x and will be removed in a future version. " +
        "Use new ListView implementation instead.",
        replaceWith = ReplaceWith("buildNewListView()"))
    internal class ListViewRecyclerAdapter(
        private val children: List<ServerDrivenComponent>,
        private val viewFactory: ViewFactory,
        private val orientation: Int,
        private val rootView: RootView
    ) : RecyclerView.Adapter<ViewHolder>() {

        override fun getItemViewType(position: Int): Int = position

        override fun onCreateViewHolder(parent: ViewGroup, position: Int): ViewHolder {
            val view = viewFactory.makeBeagleFlexView(rootView).also {
                val width = if (orientation == RecyclerView.VERTICAL)
                    ViewGroup.LayoutParams.MATCH_PARENT else
                    ViewGroup.LayoutParams.WRAP_CONTENT
                val layoutParams = ViewGroup.LayoutParams(width, ViewGroup.LayoutParams.WRAP_CONTENT)
                it.layoutParams = layoutParams
                it.addServerDrivenComponent(children[position])
            }
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        }

        override fun getItemCount(): Int = children.size
    }

    internal class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)

    private fun listDirectionToRecyclerViewOrientation() = if (direction == ListDirection.VERTICAL) {
        RecyclerView.VERTICAL
    } else {
        RecyclerView.HORIZONTAL
    }

    private fun setupRecyclerView(rootView: RootView, orientation: Int) {
        val contextAdapter = ListViewContextAdapterTwo(
            template!!,
            iteratorName,
            key,
            viewFactory,
            orientation,
            rootView
        )
        recyclerView.apply {
            adapter = contextAdapter
            layoutManager = LinearLayoutManager(context, orientation, false).apply {
                setHasFixedSize(true)
            }
        }
    }

    private fun configDataSourceObserver(rootView: RootView) {
        observeBindChanges(rootView, recyclerView, dataSource!!) { value ->
            canScrollEnd = true
            val adapter = recyclerView.adapter as ListViewContextAdapterTwo
            adapter.setList(value, recyclerView.id)
            checkIfNeedToCallScrollEnd(rootView)
        }
    }

    private fun configRecyclerViewScrollListener(rootView: RootView) {
        recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                // listen if reach max and notify the ViewModel
                checkIfNeedToCallScrollEnd(rootView)
                if (cannotScrollDirectionally()) {
                    listViewIdViewModel.markHasCompletelyLoaded(recyclerView.id)
                }
            }
        })
    }

    private fun checkIfNeedToCallScrollEnd(rootView: RootView) {
        onScrollEnd?.let {
            if (canCallOnScrollEnd()) {
                it.forEach { action ->
                    action.execute(rootView, recyclerView)
                }
                canScrollEnd = false
            }
        }
    }

    private fun canCallOnScrollEnd(): Boolean {
        val reachEnd = scrollThreshold?.let {
            val scrolledPercent = calculateScrolledPercent()
            scrolledPercent >= scrollThreshold
        } ?: cannotScrollDirectionally()
        return reachEnd && canScrollEnd
    }

    private fun cannotScrollDirectionally() = !run {
        if (direction == ListDirection.VERTICAL) {
            recyclerView.canScrollVertically(1)
        } else {
            recyclerView.canScrollHorizontally(1)
        }
    }

    private fun calculateScrolledPercent(): Float {
        var scrolledPercentage: Float
        with(recyclerView.layoutManager as LinearLayoutManager) {
            val totalItemCount = itemCount
            val lastVisible = findLastVisibleItemPosition().toFloat()
            scrolledPercentage = (lastVisible / totalItemCount) * 100
        }
        return scrolledPercentage
    }
}

internal class ListViewContextAdapterTwo(
    val template: ServerDrivenComponent,
    val iteratorName: String,
    val key: String? = null,
    val viewFactory: ViewFactory,
    val orientation: Int,
    val rootView: RootView
) : RecyclerView.Adapter<ContextViewHolderTwo>() {

    // ViewModels to manage ids and contexts
    private val viewModel = rootView.generateViewModelInstance<ScreenContextViewModel>()
    private val listViewIdViewModel = rootView.generateViewModelInstance<ListViewIdViewModel>()

    // Recyclerview id for post config changes id management
    private var recyclerId = View.NO_ID

    // Serializer to provide new template instances
    private val serializer = BeagleSerializer()

    // Items captured by ListView
    private var listItems: List<Any> = mutableListOf()

    // Struct that holds all data of each item
    private var adapterItems = listOf<BeagleAdapterItem>()

    // ViewHolders who called onInit but did not finish
    private val onInitiableWidgetsOnHolders = mutableMapOf<ContextViewHolderTwo, MutableList<OnInitiableWidget>>()

    // Quick access to the holders of the views that are OnInitiableWidgets
    private val holderToInitiableWidgets = mutableMapOf<OnInitiableWidget, ContextViewHolderTwo>()

    // Struct to manage recycled ViewHolders
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
            listViewIdViewModel,
            templateJson,
            iteratorName
        )
    }

    private fun generateView(newTemplate: ServerDrivenComponent) = viewFactory.makeBeagleFlexView(
        rootView,
        Style(flex = Flex(flexDirection = flexDirection()))
    ).apply {
//        id = View.generateViewId()
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
        holder.onBind(listId, adapterItems[position], isRecycled, position, recyclerId)
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
            if (holder.adapterPosition != DiffUtil.DiffResult.NO_POSITION) {
                manageHolderCompletelyInitializedStatus(it)
            }
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
        // Removes the ids of each view previously set to receive new ones
        clearIds(holder.itemView)
        // Iterate over the ImageViews inside each holder and release the downloaded resources before the new image is set
        holder.directNestedImageViews.forEach {
            it.setImageDrawable(null)
        }
    }

    private fun clearIds(view: View) {
        view.id = View.NO_ID
        if (view is ViewGroup) {
            view.children.forEach {
                clearIds(it)
            }
        }
    }

    override fun onViewAttachedToWindow(holder: ContextViewHolderTwo) {
        super.onViewAttachedToWindow(holder)
        // For every view, the moment it is displayed, its completely initialized status is checked and updated.
        // This validation must be done here to cover the cases where onInit is executed before the item is visible.
        if (!adapterItems[holder.adapterPosition].completelyInitialized) {
            // Marks holders with onInit not to be recycled until they are finished
            if (holder.isRecyclable) {
                holder.setIsRecyclable(false)
            }
            manageHolderCompletelyInitializedStatus(holder)
        }
    }

    fun setList(list: List<Any>?, recyclerId: Int) {
        list?.let {
            if (list != listItems) {
                listViewIdViewModel.createSingleManagerByListViewId(recyclerId, listItems.isEmpty())
                clearAdapterContent()
                this.recyclerId = recyclerId
                listItems = list
                adapterItems = list.map { BeagleAdapterItem(data = it.normalizeContextValue()) }
                notifyDataSetChanged()
            }
        } ?: clearList()
    }

    private fun clearList() {
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
    private val listViewIdViewModel: ListViewIdViewModel,
    private val jsonTemplate: String,
    private val iteratorName: String
) : RecyclerView.ViewHolder(itemView) {

    private val viewsWithId = mutableMapOf<String, View>()
    private val viewsWithContext = mutableListOf<View>()
    private val directNestedRecyclers = mutableListOf<RecyclerView>()
    val directNestedImageViews = mutableListOf<ImageView>()
    private val contextComponents = mutableListOf<ContextData>()
    val initiableWidgets = mutableListOf<OnInitiableWidget>()

    init {
        initializeViewsWithIdAndOnInit(template)
        initializeViewsWithContextAndRecyclers(itemView)
    }

    private fun initializeViewsWithIdAndOnInit(component: ServerDrivenComponent) {
        (component as? OnInitiableWidget)?.let {
            component.onInit?.let {
                initiableWidgets.add(component)
            }
        }
        (component as? IdentifierComponent)?.let {
            component.id?.let { id ->
                viewsWithId.put(id, itemView.findViewById(id.toAndroidId()))
            }
        }
        if (component is SingleChildComponent) {
            initializeViewsWithIdAndOnInit(component.child)
        } else if (component is MultiChildComponent) {
            component.children.forEach { child ->
                initializeViewsWithIdAndOnInit(child)
            }
        }
    }

    private fun initializeViewsWithContextAndRecyclers(view: View) {
        if (view.getContextData() != null) {
            viewsWithContext.add(view)
        }
        if (view is ImageView) {
            directNestedImageViews.add(view)
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
    fun onBind(
        listId: String,
        beagleAdapterItem: BeagleAdapterItem,
        isRecycled: Boolean,
        position: Int,
        recyclerId: Int
    ) {
        // Clear references to context components
        contextComponents.clear()
        // We check if its holder has been recycled and update its references
        val newTemplate = if (isRecycled) {
            serializer.deserializeComponent(jsonTemplate)
        } else {
            template
        }
        // Using a new template reference we populate the components with context
        initializeContextComponents(newTemplate)
        // Checks whether views with ids and context have been updated based on the key and updates or restore them
        if (beagleAdapterItem.firstTimeBinding) {
            // Since the context needs unique id references for each view, we update them here
            updateIdToEachSubView(listId, beagleAdapterItem, isRecycled, position, recyclerId)
            // If the holder is being recycled
            if (isRecycled) {
                // We set the template's default contexts for each view with context
                setDefaultContextToEachContextView()
                // For each RecyclerView nested directly when recycled, we generate a new adapter
                generateAdapterToEachDirectNestedRecycler(beagleAdapterItem)
            } else {
                // When this item is not recycled, we simply recover your current adapters
                useCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem)
            }
        } else {
            // But if that item on the list already has ids created, we retrieve them
            restoreIds(beagleAdapterItem)
            // Recovers adapters previously created for the RecyclerViews of this cell
            restoreAdapters(beagleAdapterItem)
            // We also recover the contexts of all previously created views with context
            restoreContexts()
        }
        // Finally, we updated the context of that cell effectively.
        setContext(iteratorName, beagleAdapterItem)
        // Mark this position on the list as finished
        beagleAdapterItem.firstTimeBinding = false
    }

    private fun initializeContextComponents(component: ServerDrivenComponent) {
        (component as? ContextComponent)?.let {
            component.context?.let {
                contextComponents.add(it)
            }
        }
        if (component is SingleChildComponent) {
            initializeContextComponents(component.child)
        } else if (component is MultiChildComponent) {
            component.children.forEach { child ->
                initializeContextComponents(child)
            }
        }
    }

    private fun updateIdToEachSubView(
        listId: String,
        beagleAdapterItem: BeagleAdapterItem,
        isRecycled: Boolean,
        position: Int,
        recyclerId: Int
    ) {
        val itemViewId = bindIdToViewModel(itemView, isRecycled, position, recyclerId)
        itemView.id = itemViewId
        beagleAdapterItem.viewIds.add(itemViewId)

        viewsWithId.forEach { (id, view) ->
            val identifierViewId = listViewIdViewModel.getViewId(recyclerId, position, id, listId)
            view.id = identifierViewId
            beagleAdapterItem.viewIds.add(identifierViewId)
        }

        val viewsWithContextAndWithoutId = viewsWithContext.filterNot { viewsWithId.containsValue(it) }
        viewsWithContextAndWithoutId.forEach {
            val subViewId = bindIdToViewModel(it, isRecycled, position, recyclerId)
            it.id = subViewId
            beagleAdapterItem.viewIds.add(subViewId)
        }
    }

    private fun bindIdToViewModel(view: View, isRecycled: Boolean, position: Int, recyclerId: Int): Int {
        return if (view.id != View.NO_ID && !isRecycled) {
            listViewIdViewModel.setViewId(recyclerId, position, view.id)
        } else {
            listViewIdViewModel.getViewId(recyclerId, position)
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

    private fun generateAdapterToEachDirectNestedRecycler(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
            val oldAdapter = it.adapter as ListViewContextAdapterTwo
            val updatedAdapter = ListViewContextAdapterTwo(
                oldAdapter.template,
                oldAdapter.iteratorName,
                oldAdapter.key,
                oldAdapter.viewFactory,
                oldAdapter.orientation,
                oldAdapter.rootView
            )
            it.swapAdapter(updatedAdapter, false)
            beagleAdapterItem.directNestedAdapters.add(updatedAdapter)
        }
    }

    private fun useCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
            beagleAdapterItem.directNestedAdapters.add(it.adapter as ListViewContextAdapterTwo)
        }
    }

    private fun restoreIds(beagleAdapterItem: BeagleAdapterItem) {
        val temporaryViewIds: LinkedList<Int> = LinkedList(beagleAdapterItem.viewIds)
        temporaryViewIds.pollFirst()?.let { savedId ->
            itemView.id = savedId
        }
        viewsWithId.values.forEach { viewWithId ->
            temporaryViewIds.pollFirst()?.let { savedId ->
                viewWithId.id = savedId
            }
        }
        val viewsWithContextAndWithoutId = viewsWithContext.filterNot { viewsWithId.containsValue(it) }
        viewsWithContextAndWithoutId.forEach { viewWithContext ->
            temporaryViewIds.pollFirst()?.let { savedId ->
                viewWithContext.id = savedId
            }
        }
    }

    private fun restoreContexts() {
        viewsWithContext.forEach {
            viewModel.restoreContext(it)
        }
    }

    private fun restoreAdapters(beagleAdapterItem: BeagleAdapterItem) {
        val temporaryNestedAdapters: LinkedList<ListViewContextAdapterTwo> = LinkedList(beagleAdapterItem.directNestedAdapters)
        directNestedRecyclers.forEach {
            it.swapAdapter(temporaryNestedAdapters.pollFirst(), false)
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
    var viewIds: LinkedList<Int> = LinkedList(),
    val data: Any,
    var completelyInitialized: Boolean = false,
    var firstTimeBinding: Boolean = true,
    val directNestedAdapters: LinkedList<ListViewContextAdapterTwo> = LinkedList()
)
