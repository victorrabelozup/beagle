package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.view.BeagleTextView
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.setup.Environment
import br.com.zup.beagleui.framework.view.ViewFactory
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkObject
import io.mockk.slot
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class UndefinedViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var textView: BeagleTextView

    private val textSlot = slot<String>()
    private val textColorSlot = slot<Int>()
    private val backgroundColorSlot = slot<Int>()

    @InjectMockKs
    private lateinit var undefinedViewRenderer: UndefinedViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.environment } returns Environment.DEBUG
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.text = capture(textSlot) } just Runs
        every { textView.setTextColor(capture(textColorSlot)) } just Runs
        every { textView.setBackgroundColor(capture(backgroundColorSlot)) } just Runs
        every { rootView.getContext() } returns context
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun build_should_create_a_TexView_with_a_undefinedWidget_text() {
        val actual = undefinedViewRenderer.build(rootView)

        assertTrue(actual is TextView)
        assertEquals("undefined widget", textSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_textColor_RED() {
        undefinedViewRenderer.build(rootView)

        assertEquals(Color.RED, textColorSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_backgroundColor_YELLOW() {
        undefinedViewRenderer.build(rootView)

        assertEquals(Color.YELLOW, backgroundColorSlot.captured)
    }

    @Test
    fun build_should_create_View_when_Environment_is_PRODUCTION() {
        // Given
        every { BeagleEnvironment.environment } returns Environment.PRODUCTION
        every { viewFactory.makeView(any()) } returns textView

        // When
        undefinedViewRenderer.build(rootView)

        // Then
        verify(exactly = 1) { viewFactory.makeView(context) }
    }
}