package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.graphics.Color
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Expanded
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import br.com.zup.beagle.extensions.once

private const val DEFAULT_COLOR = 0xFFFFFF

class ContainerViewRendererTest {

    @MockK
    private lateinit var container: Container
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
    private lateinit var widget: Widget
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View

    private lateinit var containerViewRenderer: ContainerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Color::class)

        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { container.header } returns null
        every { container.content } returns widget
        every { container.footer } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { Color.parseColor(any()) } returns DEFAULT_COLOR
        every { rootView.getContext() } returns context

        containerViewRenderer = ContainerViewRenderer(
            container,
            viewRendererFactory,
            viewFactory
        )
    }

    @Test
    fun build_should_create_a_container_with_flexDirection_COLUMN_and_justifyContent_SPACE_BETWEEN() {
        // Given
        val flexValues = mutableListOf<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flexValues)) } returns beagleFlexView

        // When
        containerViewRenderer.build(rootView)


        // Then
        assertEquals(FlexDirection.COLUMN, flexValues[0].flexDirection)
        assertEquals(JustifyContent.SPACE_BETWEEN, flexValues[0].justifyContent)
    }

    @Test
    fun build_should_call_header_builder_and_add_to_container_view() {
        // Given
        every { container.header } returns widget

        // When
        containerViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { viewRendererFactory.make(widget) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
    }

    @Test
    fun build_should_call_content_builder() {
        // Given
        val content = mockk<Widget>()
        val expanded = slot<Expanded>()
        every { container.content } returns content
        every { viewRendererFactory.make(capture(expanded)) } returns viewRenderer

        // When
        containerViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewRendererFactory.make(expanded.captured) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
        assertEquals(content, expanded.captured.child)
    }

    @Test
    fun build_should_call_footer_builder_and_add_to_container_view() {
        // Given
        every { container.footer } returns widget

        // When
        containerViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { viewRendererFactory.make(widget) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
    }
}
