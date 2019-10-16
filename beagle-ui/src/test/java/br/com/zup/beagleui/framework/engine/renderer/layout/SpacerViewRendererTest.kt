package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.Spacer
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.slot
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class SpacerViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    private lateinit var spacerViewRenderer: SpacerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        spacerViewRenderer = SpacerViewRenderer(
            Spacer(10.0),
            viewRendererFactory,
            viewFactory
        )
    }

    @Test
    fun build() {
        // Given
        val beagleFlexView = mockk<BeagleFlexView>()
        val context = mockk<Context>()
        val flexSlot = slot<Flex>()
        every { viewFactory.makeBeagleFlexView(context, capture(flexSlot)) } returns beagleFlexView

        // When
        val actual = spacerViewRenderer.build(context)

        // Then
        assertNotNull(actual)
        assertEquals(10.0, flexSlot.captured.size.width?.value)
        assertEquals(10.0, flexSlot.captured.size.height?.value)
    }
}