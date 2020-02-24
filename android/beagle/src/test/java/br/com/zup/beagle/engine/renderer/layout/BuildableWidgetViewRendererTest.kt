package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.ComposeComponent
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class BuildableWidgetViewRendererTest {

    @MockK
    private lateinit var component: ComposeComponent
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @InjectMockKs
    private lateinit var viewRenderer: BuildableWidgetViewRenderer

    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var context: Context

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { rootView.getContext() } returns context
        every { beagleFlexView.addServerDrivenComponent(any(), any()) } just Runs
    }

    @Test
    fun build_should_create_view() {
        // WHEN
        val actual = viewRenderer.build(rootView)

        // THEN
        assertEquals(beagleFlexView, actual)
    }

    @Test
    fun build_should_makeBeagleFlexView() {
        // WHEN
        viewRenderer.build(rootView)

        // THEN
        verify(exactly = once()) { viewFactory.makeBeagleFlexView(context) }
    }

    @Test
    fun build_should_addServerDrivenComponent() {
        // WHEN
        viewRenderer.build(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.addServerDrivenComponent(component, rootView) }
    }
}