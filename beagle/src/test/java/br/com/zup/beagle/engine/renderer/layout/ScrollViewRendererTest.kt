package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import android.widget.HorizontalScrollView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Stack
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import io.mockk.verify
import junit.framework.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class ScrollViewRendererTest {

    @MockK
    private lateinit var scroll: ScrollView
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var scrollView: android.widget.ScrollView
    @MockK
    private lateinit var horizontalScrollView: HorizontalScrollView
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var widgets: List<Widget>

    private val scrollBarEnabled = slot<Boolean>()
    private val stack = slot<Stack>()

    @InjectMockKs
    private lateinit var scrollViewRenderer: ScrollViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { scrollView.addView(any()) } just Runs
        every { horizontalScrollView.addView(any()) } just Runs
        every { viewRendererFactory.make(capture(stack)) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { rootView.getContext() } returns context
        every { scroll.children } returns widgets
        every { viewFactory.makeScrollView(any()) } returns scrollView
        every { viewFactory.makeHorizontalScrollView(any()) } returns horizontalScrollView
    }

    @Test
    fun when_scrollDirection_VERTICAL_and_scrollBarEnabled_true_build_should_create_a_scrollView() {
        // Given
        every { scroll.scrollDirection } returns ScrollAxis.VERTICAL
        every { scroll.scrollBarEnabled } returns true
        every { scrollView.isVerticalScrollBarEnabled = capture(scrollBarEnabled) } just Runs

        // When
        scrollViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewFactory.makeScrollView(context) }
        verify(exactly = once()) { viewRenderer.build(rootView) }
        verify(exactly = once()) { scrollView.addView(view) }
        verify(exactly = once()) { viewRendererFactory.make(stack.captured) }
        assertEquals(true, scrollBarEnabled.captured)
        assertEquals(scroll.children, stack.captured.children)
    }

    @Test
    fun when_scrollDirection_HORIZONTAL_and_scrollBarEnabled_false_build_should_create_a_scrollView() {
        // Given
        every { scroll.scrollDirection } returns ScrollAxis.HORIZONTAL
        every { scroll.scrollBarEnabled } returns false
        every {
            horizontalScrollView.isHorizontalScrollBarEnabled = capture(scrollBarEnabled)
        } just Runs

        // When
        scrollViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewFactory.makeHorizontalScrollView(context) }
        verify(exactly = once()) { viewRenderer.build(rootView) }
        verify(exactly = once()) { horizontalScrollView.addView(view) }
        verify(exactly = once()) { viewRendererFactory.make(stack.captured) }
        assertEquals(false, scrollBarEnabled.captured)
        assertEquals(scroll.children, stack.captured.children)
    }
}
