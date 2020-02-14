package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.view.BeagleView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.lazy.LazyComponent
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

private val URL = RandomData.httpUrl()

class LazyComponentViewRendererTest {

    @MockK
    private lateinit var lazyComponent: LazyComponent
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @RelaxedMockK
    private lateinit var beagleView: BeagleView
    @MockK
    private lateinit var initialStateView: View
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context

    @InjectMockKs
    private lateinit var lazyComponentViewRenderer: LazyComponentViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic("br.com.zup.beagle.utils.WidgetExtensionsKt")

        val initialState = mockk<ServerDrivenComponent>()

        every { viewFactory.makeBeagleView(any()) } returns beagleView
        every { rootView.getContext() } returns context
        every { lazyComponent.initialState } returns initialState
        every { lazyComponent.path } returns URL
        every { initialState.toView(rootView) } returns initialStateView
    }

    @Test
    fun build_should_call_make_a_BeagleView() {
        val actual = lazyComponentViewRenderer.build(rootView)

        assertTrue(actual is BeagleView)
    }

    @Test
    fun build_should_add_initialState_and_trigger_updateView() {
        lazyComponentViewRenderer.build(rootView)

        verify(exactly = once()) { beagleView.addView(initialStateView) }
        verify(exactly = once()) { beagleView.updateView(rootView, URL, initialStateView) }
    }
}