package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import android.widget.FrameLayout
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.view.BeagleUIActivity
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.NavigationBar
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.After
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

private const val TITLE = "Toolbar"
private val MARGIN_BORDER: Int = 16.dp()
private val MARGIN_WIDGET: Int = 32.dp()
private val MARGIN_TITLE: Int = 72.dp()

class NavigationBarViewRendererTest {

    @MockK
    private lateinit var navigationBar: NavigationBar
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK(relaxed = true)
    private lateinit var context: BeagleUIActivity
    @MockK
    private lateinit var rootView: RootView
    @MockK(relaxed = true)
    private lateinit var frameLayout: FrameLayout
    @MockK
    private lateinit var widget: Widget
    @MockK(relaxed = true)
    private lateinit var toolbar: Toolbar
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK(relaxed = true)
    private lateinit var frameLayoutParams: FrameLayout.LayoutParams
    @MockK
    private lateinit var viewWidget: View

    @InjectMockKs
    private lateinit var navigationBarViewRenderer: NavigationBarViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.application } returns mockk {
            every { resources.displayMetrics } returns mockk() {
                density = 10f
            }
        }

        every { rootView.getContext() } returns context

        every { navigationBar.title } returns TITLE

        every { viewRendererFactory.make(any()) } returns viewRenderer

        every { viewRenderer.build(rootView) } returns viewWidget

        every { viewFactory.makeFrameLayout(context) } returns frameLayout
        every { viewFactory.makeFrameLayoutParams(any(), any()) } returns frameLayoutParams
        every { viewFactory.makeNavigationBar(context) } returns toolbar
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
    }

    private fun createNavBarWidgets(leading: Widget?, trailing: Widget?) {
        every { navigationBar.leading } returns leading
        every { navigationBar.trailing } returns trailing
    }

    @Test
    fun build_should_return_a_frame_layout_with_title() {
        // Given
        createNavBarWidgets(widget, null)
        val titleCapture = slot<String>()
        every { toolbar.title = capture(titleCapture) } just Runs

        // When
        val view = navigationBarViewRenderer.build(rootView)

        // Then
        assertTrue(view is FrameLayout)
        assertEquals(navigationBar.title, titleCapture.captured)
    }

    @Test
    fun build_should_return_a_toolbar_with_back_button() {
        // Given
        createNavBarWidgets(null, null)

        // When
        navigationBarViewRenderer.build(rootView)

        // Then
        verify(exactly = 1) { frameLayout.addView(toolbar) }
        verify(exactly = 1) { context.setSupportActionBar(toolbar) }
    }

    @Test
    fun build_should_return_a_toolbar_with_leading_and_trailing() {
        // Given
        createNavBarWidgets(widget, widget)

        // When
        navigationBarViewRenderer.build(rootView)

        // Then
        verify(exactly = 2) { frameLayout.addView(viewWidget, frameLayoutParams) }
    }

    @Test
    fun build_should_return_leading_with_params() {
        // Given
        createNavBarWidgets(widget, null)
        val marginStartCapture = slot<Int>()
        every { frameLayoutParams.marginStart = capture(marginStartCapture) } just Runs
        val marginEndCapture = slot<Int>()
        every { frameLayoutParams.marginEnd = capture(marginEndCapture) } just Runs
        val marginTitleCapture = slot<Int>()
        every { toolbar.titleMarginStart = capture(marginTitleCapture) } just Runs

        // When
        navigationBarViewRenderer.build(rootView)

        // Then
        assertEquals(MARGIN_BORDER, marginStartCapture.captured)
        assertEquals(MARGIN_WIDGET, marginEndCapture.captured)
        assertEquals(MARGIN_TITLE, marginTitleCapture.captured)
    }

    @Test
    fun build_should_return_trailing_with_params() {
        // Given
        createNavBarWidgets(null, widget)
        val marginStartCapture = slot<Int>()
        every { frameLayoutParams.marginStart = capture(marginStartCapture) } just Runs
        val marginEndCapture = slot<Int>()
        every { frameLayoutParams.marginEnd = capture(marginEndCapture) } just Runs

        // When
        navigationBarViewRenderer.build(rootView)

        // Then
        assertEquals(0, marginStartCapture.captured)
        assertEquals(MARGIN_BORDER, marginEndCapture.captured)
    }
}