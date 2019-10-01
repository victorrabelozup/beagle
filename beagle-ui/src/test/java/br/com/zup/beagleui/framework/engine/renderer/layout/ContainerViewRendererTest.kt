package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.widget.ScrollView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaNode
import com.facebook.yogalayout.YogaLayout
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class ContainerViewRendererTest {

    @MockK
    private lateinit var container: Container
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var yogaFactory: YogaFactory

    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var yogaLayout: YogaLayout
    @MockK
    private lateinit var yogaNode: YogaNode
    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var scrollView: ScrollView

    private lateinit var containerViewRenderer: ContainerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { viewFactory.makeScrollView(any()) } returns scrollView
        every { scrollView.addView(any()) } just Runs
        every { yogaFactory.makeYogaLayout(any()) } returns yogaLayout
        every { yogaFactory.makeYogaNode() } returns yogaNode
        every { yogaLayout.yogaNode } returns yogaNode
        every { yogaLayout.addView(any()) } just Runs
        every { yogaLayout.addView(any(), any<YogaNode>()) } just Runs
        every { yogaNode.flex = any() } just Runs
        every { yogaNode.flexDirection = any() } just Runs
        every { yogaNode.justifyContent = any() } just Runs
        every { container.header } returns null
        every { container.content } returns widget
        every { container.footer } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view

        containerViewRenderer = ContainerViewRenderer(
            container,
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )
    }

    @Test
    fun build_should_create_a_container_with_flexDirection_COLUMN_and_justifyContent_SPACE_BETWEEN() {
        containerViewRenderer.build(context)

        verify(exactly = 1) { yogaNode.flexDirection = YogaFlexDirection.COLUMN }
        verify(exactly = 1) { yogaNode.justifyContent = YogaJustify.SPACE_BETWEEN }
    }

    @Test
    fun build_should_call_header_builder_and_add_to_container_view() {
        // Given
        every { container.header } returns widget

        // When
        containerViewRenderer.build(context)

        // Then
        verify(atLeast = 1) { viewRendererFactory.make(widget) }
        verify(atLeast = 1) { viewRenderer.build(context) }
        verify(atLeast = 1) { yogaLayout.addView(view) }
    }

    @Test
    fun build_should_call_content_builder() {
        // Given
        val content = mockk<Widget>()
        val containerViewRendererMock = mockk<ContainerViewRenderer>()
        every { container.content } returns content
        every { viewRendererFactory.make(content) } returns containerViewRendererMock
        every { containerViewRendererMock.build(context) } returns view

        // When
        containerViewRenderer.build(context)

        // Then
        verify(exactly = 1) { viewRendererFactory.make(content) }
        verify(exactly = 1) { containerViewRendererMock.build(context) }
    }

    @Test
    fun build_should_create_a_scrollView() {
        // When
        containerViewRenderer.build(context)

        // Then
        verify(exactly = 1) { viewFactory.makeScrollView(context) }
        verify(exactly = 1) { scrollView.addView(yogaLayout) }
        verify(exactly = 1) { yogaLayout.addView(view) }
        verify(atLeast = 2) { yogaNode.flex = 1.0f }
        verify(exactly = 1) { yogaLayout.addView(scrollView, yogaNode) }
    }

    @Test
    fun build_should_call_footer_builder_and_add_to_container_view() {
        // Given
        every { container.footer } returns widget

        // When
        containerViewRenderer.build(context)

        // Then
        verify(atLeast = 1) { viewRendererFactory.make(widget) }
        verify(atLeast = 1) { viewRenderer.build(context) }
        verify(atLeast = 1) { yogaLayout.addView(view) }
    }
}