package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.InputWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class FormInputViewRendererTest {

    @MockK
    private lateinit var formInput: FormInput
    @MockK
    private lateinit var inputWidget: InputWidget
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var view: View

    private lateinit var formInputViewRenderer: FormInputViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        formInputViewRenderer = FormInputViewRenderer(
            formInput,
            viewRendererFactory,
            viewFactory
        )

        every { formInput.child } returns inputWidget
        every { viewRendererFactory.make(formInput.child) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { view.tag = any() } just Runs
    }

    @Test
    fun build_should_make_child() {
        val actual = formInputViewRenderer.build(rootView)

        assertEquals(view, actual)
    }

    @Test
    fun build_should_set_widget_on_tag() {
        formInputViewRenderer.build(rootView)

        verify(exactly = once()) { view.tag = formInput }
    }
}