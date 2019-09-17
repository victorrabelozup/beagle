package br.com.zup.beagleui.framework.engine

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.makeComponentRenderer
import br.com.zup.beagleui.framework.widget.core.Widget
import com.facebook.litho.ComponentContext
import com.facebook.litho.LithoView

class BeagleViewBuilder {

    fun build(context: Context, widget: Widget): View {
        val componentRenderer = makeComponentRenderer(widget)
        val componentContext = ComponentContext(context)
        val component = componentRenderer.build(componentContext)
        return LithoView.create(context, component)
    }

}
