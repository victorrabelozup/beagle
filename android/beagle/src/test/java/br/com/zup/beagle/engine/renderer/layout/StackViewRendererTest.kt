package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Stack
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class StackViewRendererTest : BaseTest() {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView

    @MockK
    private lateinit var stack: Stack
    @RelaxedMockK
    private lateinit var context: Context

    @RelaxedMockK
    private lateinit var children: List<ServerDrivenComponent>

    @RelaxedMockK
    private lateinit var beagleFlexView:BeagleFlexView

    @InjectMockKs
    private lateinit var stackViewRenderer: StackViewRenderer

    private val clipChildren = slot<Boolean>()
    private val flex = slot<Flex>()

    @Test
    fun build() {
        // Given
        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { rootView.getContext() } returns context
        every { beagleFlexView.clipChildren = capture(clipChildren) } just Runs
        every { beagleFlexView.addView(any(), capture(flex)) } just Runs
        every { stack.children } returns children

        // When
        stackViewRenderer.build(rootView)

        // Then
        assertEquals(false, clipChildren.captured)
        //assertEquals(FlexPositionType.ABSOLUTE, flex.captured.positionType)
        //verify(exactly = once()) { beagleFlexView.addView(any()) }
    }
}