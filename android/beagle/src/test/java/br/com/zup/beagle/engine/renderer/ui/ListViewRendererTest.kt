package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class ListViewRendererTest : BaseTest() {

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
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    
    private val layoutManagerSlot = slot<LinearLayoutManager>()

    private lateinit var listViewRenderer: ListViewRenderer

    override fun setUp() {
        super.setUp()

        listViewRenderer = ListViewRenderer(widget, viewFactory)

        every { beagleFlexView.addView(any()) } just Runs
        every { viewFactory.makeRecyclerView(context) } returns recyclerView
        every { recyclerView.layoutManager = capture(layoutManagerSlot) } just Runs
        every { recyclerView.adapter = any() } just Runs
        every { widget.direction } returns ListDirection.VERTICAL
        every { widget.rows } returns listOf()
        every { rootView.getContext() } returns context
        every { recyclerView.context } returns context
    }

    @Test
    fun build_should_return_a_BeagleFlexView_instance() {
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