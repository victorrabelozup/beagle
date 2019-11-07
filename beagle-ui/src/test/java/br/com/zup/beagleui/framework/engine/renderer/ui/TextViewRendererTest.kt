package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.widget.TextView
import androidx.core.widget.TextViewCompat
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.setup.TextAppearanceTheme
import br.com.zup.beagleui.framework.setup.Theme
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

private const val DEFAULT_TEXT = "Hello"
private const val DEFAULT_STYLE = "DummyStyle"

class TextViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var textView: TextView

    @MockK
    private lateinit var theme: Theme

    @MockK
    private lateinit var text: Text

    @MockK
    private lateinit var textAppearanceTheme: TextAppearanceTheme

    @InjectMockKs
    private lateinit var textViewRenderer: TextViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        mockkStatic(TextViewCompat::class)

        every { BeagleEnvironment.theme } returns theme
        every { text.style } returns DEFAULT_STYLE
        every { text.text } returns DEFAULT_TEXT
        every { theme.textAppearanceTheme } returns textAppearanceTheme
        every { textAppearanceTheme.textAppearance(any()) } returns 0
        every { TextViewCompat.setTextAppearance(any(), any()) } just Runs
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
        unmockkStatic(TextViewCompat::class)

        BeagleEnvironment.theme = null
        BeagleEnvironment.httpClient = null
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

    @Test
    fun build_should_return_a_TextView_instance_with_desired_text_no_style() {
        // Given
        val textCapture = slot<String>()
        every { BeagleEnvironment.theme } returns null
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.text = capture(textCapture) } just Runs

        // When
        val view = textViewRenderer.build(context)

        // Then
        assertTrue(view is TextView)
        verify(exactly = 0) { TextViewCompat.setTextAppearance(any(), any()) }
        assertEquals(DEFAULT_TEXT, textCapture.captured)
    }
}
