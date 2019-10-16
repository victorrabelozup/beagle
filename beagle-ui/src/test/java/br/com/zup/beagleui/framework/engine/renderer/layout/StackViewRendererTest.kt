package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
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
            viewFactory
        )
    }

    @Test
    fun build() {
        // Given
        val beagleFlexView = mockk<BeagleFlexView>()
        val context = mockk<Context>()
        val viewRenderer = mockk<ViewRenderer>()
        val view = mockk<View>()
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.context } returns context
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view

        // When
        val actual = stackViewRenderer.build(context)

        // Then
        verify(exactly = 2) { beagleFlexView.addView(view) }
        assertTrue(actual is YogaLayout)
    }
}