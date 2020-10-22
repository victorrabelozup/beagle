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
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.android.context.ContextComponent
import br.com.zup.beagle.android.context.ContextData
import br.com.zup.beagle.android.data.serializer.BeagleSerializer
import br.com.zup.beagle.android.utils.COMPONENT_NO_ID
import br.com.zup.beagle.android.utils.getContextData
import br.com.zup.beagle.android.utils.safeGet
import br.com.zup.beagle.android.utils.toAndroidId
import br.com.zup.beagle.android.view.viewmodel.ListViewIdViewModel
import br.com.zup.beagle.android.view.viewmodel.ScreenContextViewModel
import br.com.zup.beagle.android.widget.OnInitiableWidget
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.core.MultiChildComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.core.SingleChildComponent
import org.json.JSONObject
import java.util.LinkedList

@Suppress("LongParameterList")
internal class ContextViewHolder(
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
    val directNestedTextViews = mutableListOf<TextView>()
    private val contextComponents = mutableListOf<ContextData>()
    val initiableWidgets = mutableListOf<OnInitiableWidget>()
    var isAttached = false

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
                if (id != COMPONENT_NO_ID) {
                    viewsWithId[id] = itemView.findViewById(id.toAndroidId())
                }
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
        if (view is TextView) {
            directNestedTextViews.add(view)
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
        parentListViewSuffix: String?,
        key: String?,
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
            // Generates an suffix identifier based on the parent's suffix, key and item position
            generateItemSuffix(parentListViewSuffix, key, beagleAdapterItem, position)
            // Since the context needs unique id references for each view, we update them here
            updateIdToEachSubView(beagleAdapterItem, isRecycled, position, recyclerId)
            // If the holder is being recycled
            if (isRecycled) {
                // We set the template's default contexts for each view with context
                setDefaultContextToEachContextView()
                // For each RecyclerView nested directly when recycled, we generate a new adapter
                generateAdapterToEachDirectNestedRecycler(beagleAdapterItem)
            } else {
                // When this item is not recycled, we simply recover your current adapters
                saveCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem)
            }
            // We inform to each adapters directly nested the suffix
            updateDirectNestedAdaptersSuffix(beagleAdapterItem)
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

    private fun generateItemSuffix(
        parentListViewSuffix: String?,
        key: String?,
        beagleAdapterItem: BeagleAdapterItem,
        position: Int
    ) {
        if (beagleAdapterItem.itemSuffix.isEmpty()) {
            val listIdByItemKey = getSuffixByItemIdAndParentId(parentListViewSuffix, key, beagleAdapterItem, position)
            beagleAdapterItem.itemSuffix = listIdByItemKey
        }
    }

    private fun getSuffixByItemIdAndParentId(
        parentListViewSuffix: String?,
        key: String?,
        beagleAdapterItem: BeagleAdapterItem,
        position: Int
    ): String {
        return if (parentListViewSuffix.isNullOrEmpty()) {
            getListIdByKey(key, beagleAdapterItem, position)
        } else {
            "$parentListViewSuffix:" + getListIdByKey(key, beagleAdapterItem, position)
        }
    }

    private fun getListIdByKey(
        key: String?,
        beagleAdapterItem: BeagleAdapterItem,
        position: Int
    ): String {
        val listId = key?.let { ((beagleAdapterItem.data) as JSONObject).safeGet(it) } ?: position
        return listId.toString()
    }

    private fun updateIdToEachSubView(
        beagleAdapterItem: BeagleAdapterItem,
        isRecycled: Boolean,
        position: Int,
        recyclerId: Int
    ) {
        val itemViewId = bindIdToViewModel(itemView, isRecycled, position, recyclerId)
        setUpdatedIdToViewAndManagers(itemView, itemViewId, beagleAdapterItem, isRecycled)

        viewsWithId.forEach { (id, view) ->
            val identifierViewId = listViewIdViewModel.getViewId(recyclerId, position, id, beagleAdapterItem.itemSuffix)
            setUpdatedIdToViewAndManagers(view, identifierViewId, beagleAdapterItem, isRecycled)
        }

        val viewsWithContextAndWithoutId = viewsWithContext.filterNot { viewsWithId.containsValue(it) }
        viewsWithContextAndWithoutId.forEach { view ->
            val subViewId = bindIdToViewModel(view, isRecycled, position, recyclerId)
            setUpdatedIdToViewAndManagers(view, subViewId, beagleAdapterItem, isRecycled)
        }
    }

    private fun bindIdToViewModel(view: View, isRecycled: Boolean, position: Int, recyclerId: Int): Int {
        return if (view.id != View.NO_ID && !isRecycled) {
            listViewIdViewModel.setViewId(recyclerId, position, view.id)
        } else {
            listViewIdViewModel.getViewId(recyclerId, position)
        }
    }

    private fun setUpdatedIdToViewAndManagers(
        view: View,
        viewId: Int,
        beagleAdapterItem: BeagleAdapterItem,
        isRecycled: Boolean
    ) {
        view.id = viewId
        beagleAdapterItem.viewIds.add(viewId)
        if (!isRecycled) {
            viewModel.setIdToViewWithContext(view)
        }
    }

    private fun setDefaultContextToEachContextView() {
        viewsWithContext.forEach { view ->
            val contextInManager = viewModel.getContextData(view)
            val savedContext = contextComponents.firstOrNull { it.id == view.getContextData()?.id }
            val contextToUseAsDefault = contextInManager ?: savedContext
            contextToUseAsDefault?.let { contextDefault ->
                viewModel.addContext(view, contextDefault, shouldOverrideExistingContext = true)
            }
        }
    }

    private fun generateAdapterToEachDirectNestedRecycler(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
            val oldAdapter = it.adapter as ListViewContextAdapter
            val updatedAdapter = ListViewContextAdapter(
                oldAdapter.template,
                oldAdapter.iteratorName,
                oldAdapter.key,
                oldAdapter.viewFactory,
                oldAdapter.rootView
            )
            it.swapAdapter(updatedAdapter, false)
            beagleAdapterItem.directNestedAdapters.add(updatedAdapter)
        }
    }

    private fun saveCreatedAdapterToEachDirectNestedRecycler(beagleAdapterItem: BeagleAdapterItem) {
        directNestedRecyclers.forEach {
            beagleAdapterItem.directNestedAdapters.add(it.adapter as ListViewContextAdapter)
        }
    }

    private fun updateDirectNestedAdaptersSuffix(beagleAdapterItem: BeagleAdapterItem) {
        beagleAdapterItem.directNestedAdapters.forEach {
            it.setParentSuffix(beagleAdapterItem.itemSuffix)
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
        val temporaryNestedAdapters: LinkedList<ListViewContextAdapter> =
            LinkedList(beagleAdapterItem.directNestedAdapters)
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
