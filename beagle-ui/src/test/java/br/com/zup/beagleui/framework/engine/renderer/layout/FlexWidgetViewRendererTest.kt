package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class FlexWidgetViewRendererTest {

    private val flexWidgetChildren = listOf<Widget>(mockk())

    @MockK
    private lateinit var flexWidget: FlexWidget
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
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var buttonViewRenderer: FlexWidgetViewRenderer

    private lateinit var flexWidgetViewRenderer: FlexWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        flexWidgetViewRenderer = FlexWidgetViewRenderer(flexWidget, viewRendererFactory, viewFactory)

        every { rootView.getContext() } returns context
        every { flexWidget.flex } returns flex
        every { flexWidget.children } returns flexWidgetChildren
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.context } returns context
        every { viewRendererFactory.make(any()) } returns buttonViewRenderer
        every { buttonViewRenderer.build(any()) } returns beagleFlexView
    }

    @Test
    fun build_should_makeBeagleFlexView() {
        flexWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex) }
    }

    @Test
    fun build_should_create_a_view_from_FlexWidget_children() {
        flexWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { viewRendererFactory.make(flexWidgetChildren[0]) }
        verify(exactly = 1) { buttonViewRenderer.build(rootView) }
    }

    @Test
    fun build_should_addView_to_BeagleFlexView() {
        flexWidgetViewRenderer.build(rootView)

        verify(exactly = 1) { beagleFlexView.addView(beagleFlexView) }
    }
}