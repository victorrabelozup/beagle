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

    private val containerChildren = listOf<ServerDrivenComponent>(mockk())

    @RelaxedMockK
    private lateinit var container: Container
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var flex: Flex
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var buttonViewRenderer: ContainerViewRenderer

    @InjectMockKs
    private lateinit var containerViewRenderer: ContainerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { rootView.getContext() } returns context
        every { container.flex } returns flex
        every { container.children } returns containerChildren
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.context } returns context
        every { viewRendererFactory.make(any()) } returns buttonViewRenderer
        every { buttonViewRenderer.build(any()) } returns beagleFlexView
    }

    @Test
    fun build_should_makeBeagleFlexView() {
        containerViewRenderer.build(rootView)

        verify(exactly = once()) { viewFactory.makeBeagleFlexView(context, flex) }
    }

    @Test
    fun build_should_create_a_view_from_Container_children() {
        containerViewRenderer.build(rootView)

        verify(exactly = once()) { viewRendererFactory.make(containerChildren[0]) }
        verify(exactly = once()) { buttonViewRenderer.build(rootView) }
    }

    @Test
    fun build_should_addView_to_BeagleFlexView() {
        containerViewRenderer.build(rootView)

        verify(exactly = once()) { beagleFlexView.addView(beagleFlexView) }
    }
}