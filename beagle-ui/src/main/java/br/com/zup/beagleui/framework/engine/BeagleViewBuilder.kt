package br.com.zup.beagleui.framework.engine

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.makeViewRenderer
import br.com.zup.beagleui.framework.widget.core.Widget

class BeagleViewBuilder {

    fun build(context: Context, widget: Widget): View {
        val componentRenderer = makeViewRenderer(widget)
        return componentRenderer.build(context)
    }
}
