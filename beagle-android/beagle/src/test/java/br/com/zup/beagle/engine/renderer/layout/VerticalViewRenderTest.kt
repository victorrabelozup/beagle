package br.com.zup.beagle.engine.renderer.layout

import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Vertical
import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class VerticalViewRenderTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
    }

    @Test
    fun getYogaFlexDirection_should_return_COLUMN_REVERSE_when_reversed_is_true() {
        // Given
        val verticalViewRenderer = VerticalViewRender(
            Vertical(listOf(), reversed = true),
            viewRendererFactory,
            viewFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(FlexDirection.COLUMN_REVERSE, actual)
    }

    @Test
    fun getYogaFlexDirection_should_return_COLUMN_when_reversed_is_false() {
        // Given
        val verticalViewRenderer = VerticalViewRender(
            Vertical(listOf(), reversed = false),
            viewRendererFactory,
            viewFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(FlexDirection.COLUMN, actual)
    }
}