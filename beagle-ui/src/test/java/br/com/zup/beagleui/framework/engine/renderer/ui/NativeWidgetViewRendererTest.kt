package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class NativeWidgetViewRendererTest {

    @MockK
    private lateinit var widget: NativeWidget
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var widgetViewFactory: WidgetViewFactory<NativeWidget>

    private lateinit var nativeWidgetViewRenderer: NativeWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        nativeWidgetViewRenderer = NativeWidgetViewRenderer(widget, viewRendererFactory)

        mockkObject(BeagleEnvironment)
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun build_should_make_a_native_view() {
        // Given
        every { widgetViewFactory.make(context, widget) } returns view
        every { BeagleEnvironment.widgets } returns mapOf(Pair(
            widget::class.java as Class<NativeWidget>,
            widgetViewFactory
        ))

        // When
        val actual = nativeWidgetViewRenderer.build(context)

        // Then
        assertEquals(view, actual)
    }

    @Test
    fun build_should_make_a_undefined_view_when_no_registered_view_is_found() {
        // Given
        val undefinedViewRenderer = mockk<UndefinedViewRenderer>()
        every { BeagleEnvironment.widgets } returns mapOf()
        every { viewRendererFactory.makeUndefinedViewRenderer() } returns undefinedViewRenderer
        every { undefinedViewRenderer.build(any()) } returns view

        // When
        val actual = nativeWidgetViewRenderer.build(context)

        // Then
        assertEquals(view, actual)
        verify(exactly = 1) { viewRendererFactory.makeUndefinedViewRenderer() }
        verify(exactly = 1) { undefinedViewRenderer.build(context) }
    }
}
