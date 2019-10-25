package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.utils.viewRenderer
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class WidgetExtensionsKtTest {

    @MockK
    private lateinit var viewRendererMock: ViewRendererFactory

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        viewRenderer = viewRendererMock
    }

    @Test
    fun toView() {
        // Given
        val widget = mockk<Widget>()
        val context = mockk<Context>()
        val viewRenderer = mockk< ViewRenderer>()
        val view = mockk<View>()
        every { viewRendererMock.make(widget) } returns viewRenderer
        every { viewRenderer.build(context) } returns view

        // When
        val actual = widget.toView(context)

        // Then
        assertEquals(view, actual)
    }
}