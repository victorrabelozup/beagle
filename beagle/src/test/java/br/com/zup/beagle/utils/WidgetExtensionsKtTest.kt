package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class WidgetExtensionsKtTest {

    @MockK
    private lateinit var rootView: RootView

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
        val viewRenderer = mockk< ViewRenderer>()
        val view = mockk<View>()
        every { viewRendererMock.make(widget) } returns viewRenderer
        every { viewRenderer.build(rootView) } returns view

        // When
        val actual = widget.toView(rootView)

        // Then
        assertEquals(view, actual)
    }

    @Test
    fun toWidget_should_create_a_ScreenWidget() {
        // Given
        val navigationBar = mockk<NavigationBar>()
        val header = mockk<Widget>()
        val content = mockk<Widget>()
        val footer = mockk<Widget>()
        val screen = Screen(
            navigationBar = navigationBar,
            header = header,
            content = content,
            footer = footer
        )

        // When
        val actual = screen.toWidget()

        // Then
        assertEquals(navigationBar, actual.navigationBar)
        assertEquals(header, actual.header)
        assertEquals(content, actual.content)
        assertEquals(footer, actual.footer)
    }
}