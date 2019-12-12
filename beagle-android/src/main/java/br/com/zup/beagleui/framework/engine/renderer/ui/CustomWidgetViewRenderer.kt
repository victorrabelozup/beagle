package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.core.Widget

internal class CustomWidgetViewRenderer(
    private val widget: Widget,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : UIViewRenderer {
    override fun build(rootView: RootView): View {
        val viewFactory = BeagleEnvironment.widgets[widget::class.java]
        return viewFactory?.make(rootView.getContext(), widget) ?: viewRendererFactory
            .makeUndefinedViewRenderer().build(rootView)
    }
}