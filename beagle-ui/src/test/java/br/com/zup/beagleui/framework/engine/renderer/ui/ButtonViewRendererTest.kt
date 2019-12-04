package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import androidx.core.widget.TextViewCompat
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleButtonView
import br.com.zup.beagleui.framework.widget.ui.Button
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

private const val DEFAULT_TEXT = "Hello"
private const val DEFAULT_STYLE = "DummyStyle"

class ButtonViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var buttonView: BeagleButtonView
    @MockK
    private lateinit var button: Button

    @InjectMockKs
    private lateinit var buttonViewRenderer: ButtonViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkStatic(TextViewCompat::class)
        mockkStatic("br.com.zup.beagleui.framework.utils.ViewExtensionsKt")

        every { button.style } returns DEFAULT_STYLE
        every { button.text } returns DEFAULT_TEXT
        every { buttonView.setBackgroundResource(any()) } just Runs
        every { rootView.getContext() } returns context
        every { TextViewCompat.setTextAppearance(any(), any()) } just Runs

    }

    @After
    fun after() {
        unmockkStatic(TextViewCompat::class)
    }

    @Test
    fun build_should_return_a_button_instance_and_set_data() {
        // Given
        every { viewFactory.makeButton(context) } returns buttonView
        every { buttonView.setData(any()) } just Runs

        // When
        val view = buttonViewRenderer.build(rootView)

        // Then
        assertTrue(view is android.widget.Button)
        verify(exactly = 1) { buttonView.setData(button) }
    }
}
