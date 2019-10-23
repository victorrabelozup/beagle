package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
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
    private lateinit var widgetViewFactory: WidgetViewFactory<NativeWidget>

    @InjectMockKs
    private lateinit var nativeWidgetViewRenderer: NativeWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun build_should_make_a_native_view() {
        // Given
        val view = mockk<View>()
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
}
