package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.InputWidget
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class FormInputViewRendererTest {

    @MockK
    private lateinit var formInput: FormInput
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @InjectMockKs
    private lateinit var formInputViewRenderer: FormInputViewRenderer

    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var inputWidget: InputWidget
    @MockK
    private lateinit var context: Context

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { rootView.getContext() } returns context
        every { beagleFlexView.addServerDrivenComponent(any()) } just Runs
        every { beagleFlexView.tag = any() } just Runs
        every { formInput.child } returns inputWidget
    }

    @Test
    fun buildView_should_make_child() {
        // WHEN
        val actual = formInputViewRenderer.buildView(rootView)

        // THEN
        assertEquals(beagleFlexView, actual)
    }

    @Test
    fun buildView_should_set_widget_on_tag() {
        // WHEN
        formInputViewRenderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.tag = formInput }
    }

    @Test
    fun buildView_should_addServerDrivenComponent() {
        // WHEN
        formInputViewRenderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.addServerDrivenComponent(inputWidget) }
    }
}