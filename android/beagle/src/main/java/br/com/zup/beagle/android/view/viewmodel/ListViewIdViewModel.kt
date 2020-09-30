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

package br.com.zup.beagle.android.view.viewmodel

import android.view.View
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ViewModel
import br.com.zup.beagle.android.exception.BeagleException
import br.com.zup.beagle.android.utils.toAndroidId
import java.util.LinkedList

internal const val LIST_ID_NOT_FOUND = "The parent ListView id was not found, check if you call function createIfNotExisting"

internal class ListViewIdViewModel : ViewModel(), LifecycleObserver {

    private val internalIdsByListId = mutableMapOf<Int, LocalListView>()

    fun createSingleManagerByListViewId(listViewId: Int) {
        val listViewManager = internalIdsByListId[listViewId]
        if (listViewManager == null) {
            internalIdsByListId[listViewId] = LocalListView()
        }
    }

    fun getViewId(listViewId: Int, position: Int): Int {
        val listViewManager = retrieveManager(listViewId)
        return if (!listViewManager.reused) {
            generateNewViewId(listViewManager, position)
        } else {
            pollFirstTemporaryId(listViewManager, position)
        }
    }

    fun getViewId(listViewId: Int, position: Int, componentId: String, listComponentId: String): Int {
        val listViewManager = retrieveManager(listViewId)
        return if (!listViewManager.reused) {
            generateNewViewId(listViewManager, position, componentId, listComponentId)
        } else {
            pollFirstTemporaryId(listViewManager, position)
        }
    }

    private fun retrieveManager(
        listViewId: Int
    ) = internalIdsByListId[listViewId] ?: throw BeagleException(LIST_ID_NOT_FOUND)

    private fun pollFirstTemporaryId(
        listViewManager: LocalListView,
        position: Int
    ) = listViewManager.temporaryIds[position]?.pollFirst() ?: throw BeagleException("temporary ids can't be empty")

    private fun generateNewViewId(localListView: LocalListView, position: Int): Int {
        val id = View.generateViewId()
        return addIdToLocalListView(localListView, position, id)
    }

    private fun generateNewViewId(
        localListView: LocalListView,
        position: Int,
        componentId: String,
        listComponentId: String
    ): Int {
        val id = "$componentId:$listComponentId".toAndroidId()
        return addIdToLocalListView(localListView, position, id)
    }

    private fun addIdToLocalListView(localListView: LocalListView, position: Int, id: Int): Int {
        localListView.idsByAdapterPosition[position]?.add(id)
        return id
    }

    fun prepareToReuseIds(listViewId: Int) {
        internalIdsByListId[listViewId]?.let { localListView ->
            internalIdsByListId[listViewId] = localListView.apply {
                reused = true
                temporaryIds = idsByAdapterPosition
            }
        } ?: throw BeagleException(LIST_ID_NOT_FOUND)
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
    fun connectListener() {

    }

    //getLifecycle().addObserver(mMyModel);
}

data class LocalListView(
    val idsByAdapterPosition: MutableMap<Int, LinkedList<Int>> = mutableMapOf(),
    var temporaryIds: MutableMap<Int, LinkedList<Int>> = linkedMapOf(),
    var reused: Boolean = false
)
