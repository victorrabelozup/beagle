package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.addFlexToRow
import br.com.zup.beagleui.framework.engine.renderer.makeComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.Row

class HorizontalComponentRenderer(
    private val horizontal: Horizontal
) : ComponentRenderer {
    override fun build(context: ComponentContext): Component {
        val row = Row.create(context)
            .reverse(horizontal.reversed)

        addFlexToRow(horizontal.flex, row)

        horizontal.children.forEach { child ->
            val layoutRenderer =
                makeComponentRenderer(child)
            row.child(layoutRenderer.build(context))
        }

        return row.build()
    }
}
