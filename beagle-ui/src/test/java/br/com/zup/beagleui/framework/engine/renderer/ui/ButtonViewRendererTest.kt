package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Button
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

class ButtonViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var buttonView: android.widget.Button

    private val button = Button(DEFAULT_TEXT)

    private lateinit var buttonViewRenderer: ButtonViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        buttonViewRenderer = ButtonViewRenderer(button, viewFactory)
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
        assertEquals(DEFAULT_TEXT , textCapture.captured)
    }
}
