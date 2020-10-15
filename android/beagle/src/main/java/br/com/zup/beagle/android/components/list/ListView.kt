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

package br.com.zup.beagle.android.components.list

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
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.utils.observeBindChanges
import br.com.zup.beagle.android.view.ViewFactory
import br.com.zup.beagle.android.view.custom.BeagleFlexView
import br.com.zup.beagle.android.view.viewmodel.ListViewIdViewModel
import br.com.zup.beagle.android.widget.OnInitiableWidget
import br.com.zup.beagle.android.widget.RootView
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.core.Style
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.ListDirection

@RegisterWidget
data class ListView
@Deprecated(
    message = "It was deprecated in version 1.4 and will be removed in a future version. " +
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

    /**
     * ListView is a Layout component that will define a list of views natively.
     * These views could be any Server Driven Component.
     *
     * @param children define the items on the list view.
     * @param direction define the list direction.
     *
     */
    @Deprecated(message = "It was deprecated in version 1.4 and will be removed in a future version. " +
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

    override fun buildView(rootView: RootView, parent: View?): View {
        this.rootView = rootView
        val listView = if (children.isNullOrEmpty()) {
            template?.let {
                dataSource?.let {
                    buildNewListView()
                }
            }
        } else {
            buildOldListView()
        }
        return listView!!
    }

    @Deprecated(message = "It was deprecated in version x.x and will be removed in a future version. " +
        "Use new ListView implementation instead.",
        replaceWith = ReplaceWith("buildNewListView()"))
    private fun buildOldListView(): View {
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

    private fun buildNewListView(): View {
        listViewIdViewModel = rootView.generateViewModelInstance()
        recyclerView = viewFactory.makeRecyclerView(rootView.getContext())

        val orientation = listDirectionToRecyclerViewOrientation()
        setupRecyclerView(orientation)
        configDataSourceObserver()
        configRecyclerViewScrollListener()
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
                val width = if (orientation == RecyclerView.VERTICAL) MATCH_PARENT else WRAP_CONTENT
                val layoutParams = ViewGroup.LayoutParams(width, WRAP_CONTENT)
                it.layoutParams = layoutParams
                it.addServerDrivenComponent(children[position], parent)
            }
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {}

        override fun getItemCount(): Int = children.size
    }

    internal class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)

    private fun listDirectionToRecyclerViewOrientation() = if (direction == ListDirection.VERTICAL) {
        RecyclerView.VERTICAL
    } else {
        RecyclerView.HORIZONTAL
    }

    private fun setupRecyclerView(orientation: Int) {
        val contextAdapter = ListViewContextAdapter(
            template!!,
            iteratorName,
            key,
            viewFactory,
            rootView
        )
        recyclerView.apply {
            adapter = contextAdapter
            layoutManager = LinearLayoutManager(context, orientation, false).apply {
                setHasFixedSize(true)
            }
        }
    }

    private fun configDataSourceObserver() {
        observeBindChanges(rootView, recyclerView, dataSource!!) { value ->
            canScrollEnd = true
            val adapter = recyclerView.adapter as ListViewContextAdapter
            adapter.setList(value, recyclerView.id)
            checkIfNeedToCallScrollEnd(rootView)
        }
    }

    private fun configRecyclerViewScrollListener() {
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
