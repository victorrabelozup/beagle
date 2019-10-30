package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import androidx.core.widget.TextViewCompat
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.setup.ButtonTheme
import br.com.zup.beagleui.framework.setup.Theme
import br.com.zup.beagleui.framework.widget.ui.Button
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

class ButtonViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context

    @MockK
    private lateinit var buttonView: android.widget.Button

    @MockK
    private lateinit var button: Button

    @MockK
    private lateinit var theme: Theme

    @MockK
    private lateinit var buttonTheme: ButtonTheme

    @InjectMockKs
    private lateinit var buttonViewRenderer: ButtonViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        mockkStatic(TextViewCompat::class)

        every { BeagleEnvironment.theme } returns theme
        every { theme.buttonTheme } returns buttonTheme
        every { button.style } returns DEFAULT_STYLE
        every { button.text } returns DEFAULT_TEXT
        every { buttonTheme.buttonBackground(any()) } returns 0
        every { buttonTheme.buttonTextAppearance(any()) } returns 0
        every { buttonView.setBackgroundResource(any()) } just Runs
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
    fun build_should_return_a_button_instance_with_desired_text() {
        // Given
        val textCapture = slot<String>()
        every { viewFactory.makeButton(context) } returns buttonView
        every { buttonView.text = capture(textCapture) } just Runs

        // When
        val view = buttonViewRenderer.build(context)

        // Then
        assertTrue(view is android.widget.Button)
        assertEquals(DEFAULT_TEXT, textCapture.captured)
    }

    @Test
    fun build_should_return_a_button_instance_with_desired_text_no_style() {
        // Given
        val textCapture = slot<String>()
        every { BeagleEnvironment.theme } returns null
        every { viewFactory.makeButton(context) } returns buttonView
        every { buttonView.text = capture(textCapture) } just Runs

        // When
        val view = buttonViewRenderer.build(context)

        // Then
        assertTrue(view is android.widget.Button)
        verify(exactly = 0) { TextViewCompat.setTextAppearance(any(), any()) }
        verify(exactly = 0) { buttonView.setBackgroundResource(any()) }
        assertEquals(DEFAULT_TEXT, textCapture.captured)
    }
}
