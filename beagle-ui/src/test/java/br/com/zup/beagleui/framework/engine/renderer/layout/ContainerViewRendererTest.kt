package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.ScrollView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaNode
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

private const val DEFAULT_COLOR = 0xFFFFFF

class ContainerViewRendererTest {

    @MockK
    private lateinit var container: Container
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

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
    @MockK
    private lateinit var scrollView: ScrollView

    private lateinit var containerViewRenderer: ContainerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Color::class)

        every { viewFactory.makeScrollView(any()) } returns scrollView
        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { scrollView.addView(any()) } just Runs
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { container.header } returns null
        every { container.content } returns widget
        every { container.footer } returns null
//        every { container.backgroundColor } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { Color.parseColor(any()) } returns DEFAULT_COLOR

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
        containerViewRenderer.build(context)


        // Then
        assertEquals(FlexDirection.COLUMN, flexValues[0].flexDirection)
        assertEquals(JustifyContent.SPACE_BETWEEN, flexValues[0].justifyContent)
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
        verify(atLeast = 1) { beagleFlexView.addView(view) }
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
        // Given
        val flexValues = mutableListOf<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flexValues)) } returns beagleFlexView

        // When
        containerViewRenderer.build(context)

        // Then
        verify(exactly = 1) { viewFactory.makeScrollView(context) }
        verify(exactly = 1) { scrollView.addView(beagleFlexView) }
        verify(exactly = 1) { beagleFlexView.addView(view) }
        verify(exactly = 1) { beagleFlexView.addView(scrollView, any<Flex>()) }
        assertEquals(1.0, flexValues[1].grow)
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
        verify(atLeast = 1) { beagleFlexView.addView(view) }
    }

    /*@Test
    fun build_should_add_backgroundColor_to_container_view() {
        // Given
        val backgroundColor = "#FFFFFF"
        every { container.backgroundColor } returns backgroundColor
        every { beagleFlexView.setBackgroundColor(DEFAULT_COLOR) } just Runs

        // When
        containerViewRenderer.build(context)

        // Then
        verify(exactly = 1) { beagleFlexView.setBackgroundColor(DEFAULT_COLOR) }
    }*/
}