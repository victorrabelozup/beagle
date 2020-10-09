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
import androidx.core.view.children
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.android.context.normalizeContextValue
import br.com.zup.beagle.android.data.serializer.BeagleSerializer
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.utils.safeGet
import br.com.zup.beagle.android.utils.setIsAutoGenerateIdEnabled
import br.com.zup.beagle.android.view.ViewFactory
import br.com.zup.beagle.android.view.viewmodel.ListViewIdViewModel
import br.com.zup.beagle.android.view.viewmodel.ScreenContextViewModel
import br.com.zup.beagle.android.widget.OnInitFinishedListener
import br.com.zup.beagle.android.widget.OnInitiableWidget
import br.com.zup.beagle.android.widget.RootView
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.core.Style
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import org.json.JSONObject

internal class ListViewContextAdapter(
    val template: ServerDrivenComponent,
    val iteratorName: String,
    val key: String? = null,
    val viewFactory: ViewFactory,
    val orientation: Int,
    val rootView: RootView
) : RecyclerView.Adapter<ContextViewHolder>() {

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
    private val onInitiableWidgetsOnHolders = mutableMapOf<ContextViewHolder, MutableList<OnInitiableWidget>>()

    // Quick access to the holders of the views that are OnInitiableWidgets
    private val holderToInitiableWidgets = mutableMapOf<OnInitiableWidget, ContextViewHolder>()

    // Struct to manage recycled ViewHolders
    private val recycledViewHolders = mutableListOf<ContextViewHolder>()

    // Each access generate a new instance of the template to avoid reference conflict
    private val templateJson = serializer.serializeComponent(template)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContextViewHolder {
        val newTemplate = serializer.deserializeComponent(templateJson)
        val view = generateView(newTemplate)
        return ContextViewHolder(
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
        layoutParams = RecyclerView.LayoutParams(layoutParamWidth(), layoutParamHeight())
        setIsAutoGenerateIdEnabled(false)
        addServerDrivenComponent(newTemplate, this)
    }

    private fun layoutParamWidth() = if (isOrientationVertical()) MATCH_PARENT else WRAP_CONTENT

    private fun layoutParamHeight() = if (isOrientationVertical()) WRAP_CONTENT else MATCH_PARENT

    private fun flexDirection() = if (isOrientationVertical()) FlexDirection.COLUMN else FlexDirection.ROW

    private fun isOrientationVertical() = (orientation == RecyclerView.VERTICAL)

    override fun onBindViewHolder(holder: ContextViewHolder, position: Int) {
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

    private fun handleInitiableWidgets(holder: ContextViewHolder, shouldRerunOnInit: Boolean = false) {
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

    private fun manageHolderCompletelyInitializedStatus(holder: ContextViewHolder) {
        val isHolderCompletelyInitialized = onInitiableWidgetsOnHolders[holder]?.isEmpty() ?: true
        if (isHolderCompletelyInitialized) {
            if (!holder.isRecyclable) {
                holder.setIsRecyclable(true)
            }
            adapterItems[holder.adapterPosition].completelyInitialized = true
        }
    }

    override fun onViewRecycled(holder: ContextViewHolder) {
        super.onViewRecycled(holder)
        recycledViewHolders.add(holder)
        // Removes the ids of each view previously set to receive new ones
        clearIds(holder.itemView)
        // Iterate over the ImageViews inside each holder and release the downloaded resources
        // before the new image is set
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

    override fun onViewAttachedToWindow(holder: ContextViewHolder) {
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
                clearAdapterContent()
                setRecyclerId(recyclerId)
                listItems = list
                adapterItems = list.map { BeagleAdapterItem(data = it.normalizeContextValue()) }
                notifyDataSetChanged()
            }
        } ?: clearList()
    }

    private fun clearAdapterContent() {
        adapterItems = emptyList()
        onInitiableWidgetsOnHolders.clear()
        holderToInitiableWidgets.clear()
        recycledViewHolders.clear()
    }

    private fun setRecyclerId(incomingRecyclerId: Int) {
        val recyclerIdToUse = if (incomingRecyclerId != View.NO_ID) {
            incomingRecyclerId
        } else {
            recyclerId
        }
        recyclerId = listViewIdViewModel.createSingleManagerByListViewId(recyclerIdToUse, listItems.isEmpty())
    }

    private fun clearList() {
        val initialSize = adapterItems.size
        clearAdapterContent()
        notifyItemRangeRemoved(0, initialSize)
    }

    override fun getItemCount() = adapterItems.size
}