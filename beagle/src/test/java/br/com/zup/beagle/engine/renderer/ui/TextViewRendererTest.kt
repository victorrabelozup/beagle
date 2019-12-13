package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.widget.TextView
import androidx.core.widget.TextViewCompat
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.view.BeagleTextView
import br.com.zup.beagle.widget.ui.Text
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

class TextViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var textView: BeagleTextView
    @MockK
    private lateinit var text: Text
    @MockK
    private lateinit var rootView: RootView

    @InjectMockKs
    private lateinit var textViewRenderer: TextViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkStatic(TextViewCompat::class)
        mockkStatic("br.com.zup.beagle.utils.ViewExtensionsKt")

        every { text.style } returns DEFAULT_STYLE
        every { text.text } returns DEFAULT_TEXT
        every { TextViewCompat.setTextAppearance(any(), any()) } just Runs
        every { rootView.getContext() } returns context
    }

    @After
    fun after() {
        unmockkStatic(TextViewCompat::class)
    }

    @Test
    fun build_should_return_a_TextView_instance_and_set_data() {
        // Given
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.setData(any()) } just Runs

        // When
        val view = textViewRenderer.build(rootView)

        // Then
        assertTrue(view is TextView)
        verify(exactly = 1) { textView.setData(text) }
    }
}
