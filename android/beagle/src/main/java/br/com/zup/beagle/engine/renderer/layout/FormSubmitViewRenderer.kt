package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import androidx.core.view.get
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.FormSubmit

internal class FormSubmitViewRenderer(
    override val component: FormSubmit,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<FormSubmit>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val view = viewFactory.makeBeagleFlexView(rootView.getContext()).apply {
            addServerDrivenComponent(component.child, rootView)
        }
        view[0].tag = component
        return view
    }
}