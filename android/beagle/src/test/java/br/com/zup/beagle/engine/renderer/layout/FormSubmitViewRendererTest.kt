package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.form.InputWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class FormSubmitViewRendererTest {

    @MockK
    private lateinit var formSubmit: FormSubmit
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @InjectMockKs
    private lateinit var formSubmitViewRenderer: FormSubmitViewRenderer

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
        every { formSubmit.child } returns inputWidget
    }

    @Test
    fun build_should_make_child() {
        // WHEN
        val actual = formSubmitViewRenderer.buildView(rootView)

        // THEN
        assertEquals(beagleFlexView, actual)
    }

    @Test
    fun build_should_set_widget_on_tag() {
        // WHEN
        formSubmitViewRenderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.tag = formSubmit }
    }

    @Test
    fun build_should_addServerDrivenComponent() {
        // WHEN
        formSubmitViewRenderer.buildView(rootView)

        // THEN
        verify(exactly = once()) { beagleFlexView.addServerDrivenComponent(inputWidget) }
    }
}