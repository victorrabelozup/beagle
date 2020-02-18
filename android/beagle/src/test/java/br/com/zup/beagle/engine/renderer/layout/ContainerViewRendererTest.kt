package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
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
    @InjectMockKs
    private lateinit var renderer: ContainerViewRenderer

    @MockK
    private lateinit var flex: Flex
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView

    private val containerChildren = listOf<ServerDrivenComponent>(Button(""))

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { rootView.getContext() } returns context
        every { container.flex } returns flex
        every { container.children } returns containerChildren
        every { beagleFlexView.addServerDrivenComponent(any()) } just Runs
    }

    @Test
    fun buildView_should_makeBeagleFlexView() {
        // WHEN
        renderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { viewFactory.makeBeagleFlexView(context, flex) }
    }

    @Test
    fun buildView_should_addServerDrivenComponent() {
        // WHEN
        renderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.addServerDrivenComponent(containerChildren[0]) }
    }
}