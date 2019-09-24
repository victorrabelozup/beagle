package br.com.zup.beagleui.framework.engine

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.widget.core.Widget

internal class BeagleViewBuilder(
    private val viewRendererFactory: ViewRendererFactory
) {

    fun build(context: Context, widget: Widget): View {
        val viewRenderer = viewRendererFactory.make(widget)
        return viewRenderer.build(context)
    }
}
