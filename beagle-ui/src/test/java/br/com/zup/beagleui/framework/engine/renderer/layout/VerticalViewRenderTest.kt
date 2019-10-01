package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Vertical
import com.facebook.yoga.YogaFlexDirection
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
    @MockK
    private lateinit var yogaFactory: YogaFactory

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
            viewFactory,
            yogaFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(YogaFlexDirection.COLUMN_REVERSE, actual)
    }

    @Test
    fun getYogaFlexDirection_should_return_COLUMN_when_reversed_is_false() {
        // Given
        val verticalViewRenderer = VerticalViewRender(
            Vertical(listOf(), reversed = false),
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(YogaFlexDirection.COLUMN, actual)
    }
}