package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.extensions.once
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Expanded
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class ExpandedViewRendererTest {

    @MockK
    private lateinit var expanded: Expanded
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var widget: Widget

    @InjectMockKs
    private lateinit var expandedViewRenderer: ExpandedViewRenderer

    @Before
    fun setUp() = MockKAnnotations.init(this)

    @Test
    fun build_should_create_a_expandedView() {
        // Given
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { expanded.child } returns widget
        every { rootView.getContext() } returns context
        val flexValues = slot<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flexValues)) } returns beagleFlexView

        // When
        expandedViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewFactory.makeBeagleFlexView(context, flexValues.captured) }
        verify(exactly = once()) { viewRendererFactory.make(widget) }
        verify(exactly = once()) { viewRenderer.build(rootView) }
        verify(exactly = once()) { beagleFlexView.addView(view, any<Flex>()) }
        assertEquals(1.0, flexValues.captured.grow)
    }
}