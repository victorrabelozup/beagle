package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ui.PageIndicatorViewRenderer
import br.com.zup.beagleui.framework.view.BeaglePageIndicatorView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.PageIndicator
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class PageIndicatorViewRendererTest {

    @MockK
    private lateinit var pageIndicator: PageIndicator
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var beaglePageIndicatorView: BeaglePageIndicatorView
    @InjectMockKs
    private lateinit var pageIndicatorViewRenderer: PageIndicatorViewRenderer

    @Before
    fun setUp() = MockKAnnotations.init(this, relaxUnitFun = true)

    @Test
    fun build() {
        // GIVEN
        every { rootView.getContext() } returns context
        every { viewFactory.makePageIndicator(any()) } returns beaglePageIndicatorView

        // WHEN
        pageIndicatorViewRenderer.build(rootView)

        // THEN
        verify(exactly = 1) { viewFactory.makePageIndicator(context) }
        verify(exactly = 1) { beaglePageIndicatorView.setWidget(pageIndicator) }
    }
}