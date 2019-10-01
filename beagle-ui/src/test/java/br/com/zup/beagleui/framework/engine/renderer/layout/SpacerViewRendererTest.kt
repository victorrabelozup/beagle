package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.layout.Spacer
import com.facebook.yoga.YogaNode
import com.facebook.yogalayout.YogaLayout
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class SpacerViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var yogaFactory: YogaFactory

    private lateinit var spacerViewRenderer: SpacerViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        spacerViewRenderer = SpacerViewRenderer(
            Spacer(10.0),
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )
    }

    @Test
    fun build() {
        // Given
        val yogaList = mockk<YogaLayout>()
        val yogaNode = mockk<YogaNode>()
        val context = mockk<Context>()
        every { yogaList.yogaNode } returns yogaNode
        every { yogaNode.setWidth(any()) } just Runs
        every { yogaNode.setHeight(any()) } just Runs
        every { yogaFactory.makeYogaLayout(context) } returns yogaList

        // When
        val actual = spacerViewRenderer.build(context)

        // Then
        assertNotNull(actual)
        verify { yogaNode.setWidth(10.0f) }
        verify { yogaNode.setHeight(10.0f) }
    }
}