package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.core.NativeWidget

internal class NativeWidgetViewRenderer(
    private val widget: NativeWidget,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : UIViewRenderer {
    override fun build(context: Context): View {
        val viewFactory = BeagleEnvironment.widgets[widget::class.java]
        return viewFactory?.make(context, widget) ?: viewRendererFactory
            .makeUndefinedViewRenderer().build(context)
    }
}