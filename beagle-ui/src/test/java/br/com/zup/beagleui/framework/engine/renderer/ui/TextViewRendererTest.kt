package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

private const val DEFAULT_TEXT = "Hello"

class TextViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var textView: TextView

    private val text = Text(DEFAULT_TEXT)

    private lateinit var textViewRenderer: TextViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        textViewRenderer = TextViewRenderer(text, viewFactory)
    }

    @Test
    fun build_should_return_a_TextView_instance_with_desired_text() {
        // Given
        val textCapture = slot<String>()
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.text = capture(textCapture) } just Runs

        // When
        val view = textViewRenderer.build(context)

        // Then
        assertTrue(view is TextView)
        assertEquals(DEFAULT_TEXT, textCapture.captured)
    }
}
