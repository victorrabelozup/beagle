package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class FlexSingleWidgetViewRendererTest {

    @MockK
    private lateinit var flexSingleWidget: FlexSingleWidget
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var flex: Flex
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var childWidget: Widget
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var buttonViewRenderer: ButtonViewRenderer

    private lateinit var flexSingleWidgetViewRenderer: FlexSingleWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        flexSingleWidgetViewRenderer = FlexSingleWidgetViewRenderer(flexSingleWidget, viewRendererFactory, viewFactory)

        every { flexSingleWidget.flex } returns flex
        every { flexSingleWidget.child } returns childWidget
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { viewRendererFactory.make(childWidget) } returns buttonViewRenderer
        every { buttonViewRenderer.build(any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { rootView.getContext() } returns context
    }

    @Test
    fun build_should_makeBeagleFlexView() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex) }
    }

    @Test
    fun build_should_make_a_view_from_a_child_widget() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { viewRendererFactory.make(childWidget) }
        verify(exactly = 1) { buttonViewRenderer.build(rootView) }
    }

    @Test
    fun build_should_addView_to_BeagleFlexView() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { beagleFlexView.addView(beagleFlexView) }
    }
}