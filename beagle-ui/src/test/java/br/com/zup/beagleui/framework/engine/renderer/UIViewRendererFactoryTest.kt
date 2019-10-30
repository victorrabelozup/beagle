package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.BuildableWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ListViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.NativeWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.mockk
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

class UIViewRendererFactoryTest {

    private lateinit var viewRendererFactory: UIViewRendererFactory

    @Before
    fun setUp() {
        viewRendererFactory = UIViewRendererFactory()
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
    fun make_should_return_ListViewRenderer_when_widget_is_a_ListView() {
        // Given
        val widget = mockk<ListView>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is ListViewRenderer)
    }

    @Test
    fun make_should_return_NativeWidgetViewRenderer_when_widget_is_a_NativeWidget() {
        // Given
        val widget = mockk<NativeWidget>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is NativeWidgetViewRenderer)
    }

    @Test
    fun make_should_return_BuildableWidgetViewRenderer_when_widget_is_not_a_NativeWidget() {
        // Given
        val widget = mockk<Widget>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is BuildableWidgetViewRenderer)
    }
}