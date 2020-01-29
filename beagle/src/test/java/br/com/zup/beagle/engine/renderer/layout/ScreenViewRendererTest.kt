package br.com.zup.beagle.engine.renderer.layout

import android.graphics.Color
import android.view.View
import androidx.appcompat.app.ActionBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.core.Widget
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
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.ScreenWidget
import br.com.zup.beagle.widget.layout.NavigationBar

private const val DEFAULT_COLOR = 0xFFFFFF

class ScreenViewRendererTest {

    @MockK
    private lateinit var screenWidget: ScreenWidget
    @MockK(relaxed = true)
    private lateinit var navigationBar: NavigationBar
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: AppCompatActivity
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View
    @MockK(relaxed = true)
    private lateinit var actionBar: ActionBar

    private lateinit var screenViewRenderer: ScreenViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Color::class)

        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { screenWidget.navigationBar } returns null
        every { screenWidget.header } returns null
        every { screenWidget.content } returns widget
        every { screenWidget.footer } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { Color.parseColor(any()) } returns DEFAULT_COLOR
        every { rootView.getContext() } returns context

        screenViewRenderer = ScreenViewRenderer(
            screenWidget,
            viewRendererFactory,
            viewFactory
        )
    }

    @Test
    fun build_should_create_a_screenWidget_with_flexDirection_COLUMN_and_justifyContent_SPACE_BETWEEN() {
        // Given
        val flexValues = mutableListOf<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flexValues)) } returns beagleFlexView
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)


        // Then
        assertEquals(FlexDirection.COLUMN, flexValues[0].flexDirection)
        assertEquals(JustifyContent.SPACE_BETWEEN, flexValues[0].justifyContent)
    }

    @Test
    fun build_should_call_header_builder_and_add_to_screenWidget_view() {
        // Given
        every { screenWidget.header } returns widget
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

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
        every { screenWidget.content } returns content
        every { viewRendererFactory.make(capture(expanded)) } returns viewRenderer
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewRendererFactory.make(expanded.captured) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
        assertEquals(content, expanded.captured.child)
    }

    @Test
    fun build_should_call_footer_builder_and_add_to_screenWidget_view() {
        // Given
        every { screenWidget.footer } returns widget
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { viewRendererFactory.make(widget) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
    }

    @Test
    fun build_should_configure_toolbar_when_supportActionBar_is_not_null_and_toolbar_is_null() {
        // Given
        val title = RandomData.string()
        val showBackButton = true
        every { navigationBar.title } returns title
        every { navigationBar.showBackButton } returns showBackButton
        every { screenWidget.navigationBar } returns navigationBar
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { actionBar.title = title }
        verify(atLeast = once()) { actionBar.setDisplayHomeAsUpEnabled(showBackButton) }
        verify(atLeast = once()) { actionBar.setDisplayShowHomeEnabled(showBackButton) }
        verify(atLeast = once()) { actionBar.show() }
    }

    @Test
    fun build_should_configure_toolbar_when_supportActionBar_is_not_null_and_toolbar_is_not_null() {
        // Given
        val toolbar = mockk<Toolbar>(relaxed = true)
        every { screenWidget.navigationBar } returns navigationBar
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns toolbar

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { toolbar.visibility = View.VISIBLE }
    }
}
