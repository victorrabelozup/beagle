/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import io.mockk.Called
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

private val ROWS = listOf<ServerDrivenComponent>(mockk(), mockk())

class ListViewRecyclerAdapterTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var viewRendererMock: ViewRenderer<*>
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var view: BeagleFlexView

    private lateinit var listViewRecyclerAdapter: ListViewRecyclerAdapter

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        listViewRecyclerAdapter = ListViewRecyclerAdapter(rootView, ROWS, viewFactory, RecyclerView.VERTICAL)

        every { viewFactory.makeBeagleFlexView(any()) } returns view
        every { rootView.getContext() } returns context
    }

    @Test
    fun getItemViewType_should_return_position() {
        // Given
        val position = 0

        // When
        val actual = listViewRecyclerAdapter.getItemViewType(position)

        // Then
        assertEquals(position, actual)
    }

    @Test
    fun onCreateViewHolder_should_return_ViewHolder_with_widget_view() {
        // Given
        val parent = mockk<ViewGroup>()
        val position = 0
        every { parent.context } returns context

        // When
        val actual = listViewRecyclerAdapter.onCreateViewHolder(parent, position)

        // Then
        assertEquals(view, actual.itemView)
    }

    @Test
    fun onBindViewHolder_should_do_nothing() {
        // Given
        val viewHolder = mockk<ViewHolder>()
        val position = 0

        // When
        listViewRecyclerAdapter.onBindViewHolder(viewHolder, position)

        // Then
        verify { viewHolder wasNot Called }
    }

    @Test
    fun getItemCount_should_return_rows_size() {
        val actual = listViewRecyclerAdapter.itemCount

        assertEquals(ROWS.size, actual)
    }
}