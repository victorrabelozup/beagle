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
import android.view.ViewGroup
import androidx.lifecycle.ViewModel
import br.com.zup.beagle.android.exception.BeagleException
import br.com.zup.beagle.android.utils.toAndroidId
import java.util.LinkedList

internal class ListViewIdViewModel : ViewModel() {

    private val internalIdsByListId = mutableMapOf<Int, LocalListView>()

    fun createSingleManagerByListViewId(listViewId: Int) {
        val listViewManager = internalIdsByListId[listViewId]
        if (listViewManager == null) {
            internalIdsByListId[listViewId] = LocalListView()
        }
    }

    fun getViewId(listViewId: Int, position: Int): Int {
        val listViewManager = retrieveManager(listViewId, position)
        return if (!listViewManager.reused) {
            generateNewViewId(listViewManager, position)
        } else {
            pollFirstTemporaryId(listViewManager, position)
        }
    }

    fun getViewId(listViewId: Int, position: Int, componentId: String, listComponentId: String): Int {
        val listViewManager = retrieveManager(listViewId, position)
        return if (!listViewManager.reused) {
            generateNewViewId(listViewManager, position, componentId, listComponentId)
        } else {
            pollFirstTemporaryId(listViewManager, position)
        }
    }

    private fun retrieveManager(
        listViewId: Int,
        position: Int
    ) = internalIdsByListId[listViewId] ?:
    throw BeagleException("The list id $listViewId which this view in position $position belongs to, was not found")

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

    fun prepareToReuseIds(rootView: View) {
        internalIdsByListId[rootView.id]?.let { localListView ->
            internalIdsByListId[rootView.id] = localListView.apply {
                reused = true
                temporaryIds = idsByAdapterPosition
            }
        } ?: run {
            if (rootView is ViewGroup) {
                val count = rootView.childCount
                for (i in 0 until count) {
                    val child = rootView.getChildAt(i)
                    prepareToReuseIds(child)
                }
            }
        }
    }
}

data class LocalListView(
    val idsByAdapterPosition: MutableMap<Int, LinkedList<Int>> = mutableMapOf(),
    var temporaryIds: MutableMap<Int, LinkedList<Int>> = linkedMapOf(),
    var reused: Boolean = false
)
