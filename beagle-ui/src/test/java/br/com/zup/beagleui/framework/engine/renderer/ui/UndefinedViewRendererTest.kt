package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import android.widget.TextView
import br.com.zup.beagleui.framework.view.ViewFactory
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class UndefinedViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var textView: TextView

    private val textSlot = slot<String>()
    private val textColorSlot = slot<Int>()
    private val backgroundColorSlot = slot<Int>()

    @InjectMockKs
    private lateinit var undefinedViewRenderer: UndefinedViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { viewFactory.makeTextView(context) } returns textView
        every { textView.text = capture(textSlot) } just Runs
        every { textView.setTextColor(capture(textColorSlot)) } just Runs
        every { textView.setBackgroundColor(capture(backgroundColorSlot)) } just Runs
    }

    @Test
    fun build_should_create_a_TexView_with_a_undefinedWidget_text() {
        val actual = undefinedViewRenderer.build(context)

        assertTrue(actual is TextView)
        assertEquals("undefined widget", textSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_textColor_RED() {
        undefinedViewRenderer.build(context)

        assertEquals(Color.RED, textColorSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_backgroundColor_YELLOW() {
        undefinedViewRenderer.build(context)

        assertEquals(Color.YELLOW, backgroundColorSlot.captured)
    }
}