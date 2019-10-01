package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import com.facebook.yoga.YogaFlexDirection
import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.MockK
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before

class HorizontalViewRendererTest {

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
    fun getYogaFlexDirection_should_return_ROW_REVERSE_when_reversed_is_true() {
        // Given
        val horizontalViewRenderer = HorizontalViewRenderer(
            Horizontal(listOf(), reversed = true),
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )

        // When
        val actual = horizontalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(YogaFlexDirection.ROW_REVERSE, actual)
    }

    @Test
    fun getYogaFlexDirection_should_return_ROW_when_reversed_is_false() {
        // Given
        val horizontalViewRenderer = HorizontalViewRenderer(
            Horizontal(listOf(), reversed = false),
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )

        // When
        val actual = horizontalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(YogaFlexDirection.ROW, actual)
    }
}