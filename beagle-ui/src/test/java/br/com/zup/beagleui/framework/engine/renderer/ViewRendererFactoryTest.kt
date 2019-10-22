package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.every
import io.mockk.mockk
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class ViewRendererFactoryTest {

    private lateinit var viewRendererFactory: ViewRendererFactory

    @Before
    fun setUp() {
        viewRendererFactory = ViewRendererFactory()
    }

    @Test
    fun make_should_return_ContainerViewRenderer_when_widget_is_a_Container() {
        // Given
        val widget = mockk<Container>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is ContainerViewRenderer)
    }

    @Test
    fun make_should_return_VerticalViewRender_when_widget_is_a_Vertical() {
        // Given
        val widget = mockk<Vertical>()
        every { widget.children } returns listOf()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is VerticalViewRender)
    }

    @Test
    fun make_should_return_HorizontalViewRenderer_when_widget_is_a_Horizontal() {
        // Given
        val widget = mockk<Horizontal>()
        every { widget.children } returns listOf()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is HorizontalViewRenderer)
    }

    @Test
    fun make_should_return_StackViewRenderer_when_widget_is_a_Stack() {
        // Given
        val widget = mockk<Stack>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is StackViewRenderer)
    }

    @Test
    fun make_should_return_SpacerViewRenderer_when_widget_is_a_Spacer() {
        // Given
        val widget = mockk<Spacer>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is SpacerViewRenderer)
    }

    @Test
    fun make_should_return_UndefinedViewRenderer_when_widget_is_unknown() {
        // Given
        val widget = UndefinedWidget()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is UndefinedViewRenderer)
    }

    @Test
    fun make_should_return_ButtonViewRenderer_when_widget_is_a_Button() {
        // Given
        val widget = Button(text = "")

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is ButtonViewRenderer)
    }

    @Test
    fun make_should_return_TextViewRenderer_when_widget_is_a_Text() {
        // Given
        val widget = Text(text = "")

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is TextViewRenderer)
    }

    @Test
    fun make_should_return_ImageViewRenderer_when_widget_is_a_Image() {
        // Given
        val widget = Image(name = "")

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is ImageViewRenderer)
    }

    @Test
    fun make_should_return_NetworkImageViewRenderer_when_widget_is_a_NetworkImage() {
        // Given
        val widget = NetworkImage(url = "")

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is NetworkImageViewRenderer)
    }

    @Test
    fun make_should_return_UndefinedViewRenderer_when_widget_is_a_ListView() {
        // Given
        val widget = ListView(listOf())

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is UndefinedViewRenderer)
    }
}

class UndefinedWidget : NativeWidget