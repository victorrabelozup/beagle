package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import androidx.core.view.size
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.BeaglePageIndicatorView
import br.com.zup.beagle.view.BeaglePageView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.PageIndicatorWidget
import br.com.zup.beagle.widget.layout.PageView
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class PageViewRendererTest {

    @MockK
    private lateinit var pageView: PageView
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
    private lateinit var beaglePageView: BeaglePageView
    @MockK
    private lateinit var pageViewPages: List<Widget>
    @MockK
    private lateinit var pageIndicatorWidget: PageIndicatorWidget
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var pageIndicatorView: BeaglePageIndicatorView

    @InjectMockKs
    private lateinit var pageViewRenderer: PageViewRenderer

    private val flex = mutableListOf<Flex>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        every { rootView.getContext() } returns context
        every { viewFactory.makeBeagleFlexView(any(), capture(flex)) } returns beagleFlexView
        every { viewFactory.makeViewPager(any()) } returns beaglePageView
        every { beaglePageView.childCount } returns 3
        every { pageView.pages } returns pageViewPages
        every { pageView.pages.size } returns 0
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns pageIndicatorView
    }

    @Test
    fun build_when_page_indicator_is_null() {
        // GIVEN
        every { pageView.pageIndicator } returns null

        // WHEN
        pageViewRenderer.build(rootView)

        // THEN
        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex[0]) }
        assertEquals(FlexDirection.COLUMN, flex[0].flexDirection)
        assertEquals(1.0, flex[0].grow)
        verify(exactly = 1) { viewFactory.makeViewPager(any()) }
        assertEquals(3, beaglePageView.size)
        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex[1]) }
        assertEquals(FlexDirection.COLUMN, flex[1].flexDirection)
        verify(exactly = 2) { beagleFlexView.addView(any()) }
    }

    @Test
    fun build_when_page_indicator_is_not_null() {
        // GIVEN
        every { pageView.pageIndicator } returns pageIndicatorWidget

        // WHEN
        pageViewRenderer.build(rootView)

        // THEN
        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex[0]) }
        assertEquals(FlexDirection.COLUMN, flex[0].flexDirection)
        assertEquals(1.0, flex[0].grow)
        verify(exactly = 1) { viewFactory.makeViewPager(any()) }
        assertEquals(3, beaglePageView.size)
        verify(exactly = 1) { viewFactory.makeBeagleFlexView(context, flex[1]) }
        assertEquals(FlexDirection.COLUMN, flex[1].flexDirection)
        verify(exactly = 3) { beagleFlexView.addView(any()) }
        verify(exactly = 1) { viewRenderer.build(rootView) }
        verify(exactly = 1) { viewRendererFactory.make(any()) }
    }
}