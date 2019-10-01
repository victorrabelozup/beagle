package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.ui.Button
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

class StackViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var yogaFactory: YogaFactory

    private lateinit var stackViewRenderer: StackViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        val stack = Stack(
            listOf(Button(""), Button("")),
            Flex()
        )

        stackViewRenderer = StackViewRenderer(
            stack,
            viewRendererFactory,
            viewFactory,
            yogaFactory
        )
    }

    @Test
    fun build() {
        // Given
        val yogaLayout = mockk<YogaLayout>()
        val yogaNode = mockk<YogaNode>()
        val context = mockk<Context>()
        val viewRenderer = mockk<ViewRenderer>()
        val view = mockk<View>()
        every { yogaLayout.yogaNode } returns yogaNode
        every { yogaLayout.addView(any()) } just Runs
        every { yogaLayout.context } returns context
        every { yogaFactory.makeYogaLayout(any(), any()) } returns yogaLayout
        every { yogaNode.flexDirection = any() } just Runs
        every { yogaNode.positionType = any() } just Runs
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view

        // When
        val actual = stackViewRenderer.build(context)

        // Then
        verify(exactly = 2) { yogaLayout.addView(view) }
        assertTrue(actual is YogaLayout)
    }
}