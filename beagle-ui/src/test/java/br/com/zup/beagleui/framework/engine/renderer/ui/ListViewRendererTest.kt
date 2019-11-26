package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.ListDirection
import br.com.zup.beagleui.framework.widget.ui.ListView
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class ListViewRendererTest {

    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var widget: ListView
    @MockK
    private lateinit var recyclerView: RecyclerView
    
    private val layoutManagerSlot = slot<LinearLayoutManager>()

    private lateinit var listViewRenderer: ListViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        listViewRenderer = ListViewRenderer(widget, viewFactory)

        every { viewFactory.makeRecyclerView(context) } returns recyclerView
        every { recyclerView.layoutManager = capture(layoutManagerSlot) } just Runs
        every { recyclerView.adapter = any() } just Runs
        every { widget.direction } returns ListDirection.VERTICAL
        every { widget.rows } returns listOf()
        every { rootView.getContext() } returns context
        every { recyclerView.context } returns context
    }

    @Test
    fun build_should_return_a_RecyclerView_instance() {
        val view = listViewRenderer.build(rootView)

        assertTrue(view is RecyclerView)
    }

    @Test
    fun build_should_set_orientation_VERTICAL() {
        // Given
        every { widget.direction } returns ListDirection.VERTICAL

        // When
        listViewRenderer.build(rootView)

        // Then
        assertEquals(RecyclerView.VERTICAL, layoutManagerSlot.captured.orientation)
    }

    @Test
    fun build_should_set_orientation_HORIZONTAL() {
        // Given
        every { widget.direction } returns ListDirection.HORIZONTAL

        // When
        listViewRenderer.build(rootView)

        // Then
        assertEquals(RecyclerView.HORIZONTAL, layoutManagerSlot.captured.orientation)
    }
}