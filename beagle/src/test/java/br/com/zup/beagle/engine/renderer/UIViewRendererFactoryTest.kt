package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.engine.renderer.layout.BuildableWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormInputViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormSubmitViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ListViewRenderer
import br.com.zup.beagle.engine.renderer.ui.WidgetViewRenderer
import br.com.zup.beagle.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.core.ComposeWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.core.WidgetView
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

class UIViewRendererFactoryTest {

    private lateinit var viewRendererFactory: UIViewRendererFactory

    @Before
    fun setUp() {
        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.beagleSdk } returns mockk(relaxed = true)

        viewRendererFactory = UIViewRendererFactory()
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
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
    fun make_should_return_CustomWidgetViewRenderer_when_widget_is_a_NativeWidget() {
        // Given
        val widget = mockk<WidgetView>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is WidgetViewRenderer)
    }

    @Test
    fun make_should_return_BuildableWidgetViewRenderer_when_widget_is_not_a_ComposeWidget() {
        // Given
        val widget = mockk<ComposeWidget>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is BuildableWidgetViewRenderer)
    }

    @Test
    fun make_should_return_FormInputViewRenderer_when_widget_is_a_FormInput() {
        // Given
        val widget = mockk<FormInput>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is FormInputViewRenderer)
    }

    @Test
    fun make_should_return_FormSubmitViewRenderer_when_widget_is_a_FormSubmit() {
        // Given
        val widget = mockk<FormSubmit>()

        // When
        val actual = viewRendererFactory.make(widget)

        // Then
        assertTrue(actual is FormSubmitViewRenderer)
    }
}