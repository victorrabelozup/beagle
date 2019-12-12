package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.form.FormSubmit

internal class FormSubmitViewRenderer(
    private val widget: FormSubmit,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        return viewRendererFactory.make(widget.child).build(rootView).apply {
            tag = widget
        }
    }
}