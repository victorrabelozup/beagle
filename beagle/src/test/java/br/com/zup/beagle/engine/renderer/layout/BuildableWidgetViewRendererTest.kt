package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.ComposeWidget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class BuildableWidgetViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var widget: ComposeWidget
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var viewRendererMock: ViewRenderer
    @MockK
    private lateinit var view: View

    @InjectMockKs
    private lateinit var viewRenderer: BuildableWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { widget.build() } returns widget
        every { viewRendererFactory.make(widget) } returns viewRendererMock
        every { viewRendererMock.build(rootView) } returns view
    }

    @Test
    fun build() {
        val actual = viewRenderer.build(rootView)

        assertEquals(this.view, actual)
    }
}