package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.Row

class SpacerComponentRenderer(
    private val spacer: Spacer
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        return Row.create(context)
            .widthDip(spacer.size.toFloat())
            .heightDip(spacer.size.toFloat())
            .build()
    }
}
