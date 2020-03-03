package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.BeaglePageIndicatorView
import br.com.zup.beagle.view.BeaglePageView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicatorComponent
import br.com.zup.beagle.widget.ui.Button
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class PageViewRendererTest {

    @RelaxedMockK
    private lateinit var pageView: PageView
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var beaglePageView: BeaglePageView

    private var pageViewPages = listOf<ServerDrivenComponent>(Button(""))
    @MockK
    private lateinit var pageIndicatorComponent: PageIndicatorComponent
    @MockK
    private lateinit var pageIndicatorView: BeaglePageIndicatorView
    @MockK
    private lateinit var viewRenderer: ViewRenderer<*>
    @MockK
    private lateinit var view: View

    @InjectMockKs
    private lateinit var pageViewRenderer: PageViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        every { rootView.getContext() } returns context
        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { viewFactory.makeViewPager(any()) } returns beaglePageView
        every { pageView.pages } returns pageViewPages
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
    }

    @Test
    fun build_when_page_indicator_is_null() {
        // GIVEN
        every { pageView.pageIndicator } returns null

        // WHEN
        pageViewRenderer.build(rootView)

        // THEN
        verify(exactly = once()) { viewFactory.makeViewPager(any()) }
        verify(atLeast = 2) { beagleFlexView.addView(any()) }
        verify(atLeast = 2) { viewFactory.makeBeagleFlexView(any()) }
    }

    @Test
    fun build_when_page_indicator_is_not_null() {
        // GIVEN
        every { pageView.pageIndicator } returns pageIndicatorComponent
        every { pageIndicatorComponent.toView(any()) } returns pageIndicatorView

        // WHEN
        pageViewRenderer.build(rootView)

        // THEN
        verify(exactly = 3) { beagleFlexView.addView(any()) }
    }
}