package br.com.zup.beagleui.framework.engine

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleViewBuilderTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory

    private lateinit var beagleViewBuilder: BeagleViewBuilder

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleViewBuilder = BeagleViewBuilder(viewRendererFactory)
    }

    @Test
    fun build_should_start_the_build_process_of_a_Widget() {
        // Given
        val widget = mockk<Widget>()
        val viewRenderer = mockk<ViewRenderer>()
        val context = mockk<Context>()
        val view = mockk<View>()
        every { viewRendererFactory.make(widget) } returns viewRenderer
        every { viewRenderer.build(context) } returns view

        // When
        val actual = beagleViewBuilder.build(context, widget)

        // Then
        verify(exactly = 1) { viewRendererFactory.make(widget) }
        verify(exactly = 1) { viewRenderer.build(context) }
        assertEquals(view, actual)
    }
}