package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.addFlexToColumn
import br.com.zup.beagleui.framework.engine.renderer.makeComponentRenderer
import com.facebook.litho.Column
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext

class VerticalComponentRender(
    private val vertical: Vertical
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        val column = Column.create(context)
            .reverse(vertical.reversed)

        addFlexToColumn(vertical.flex, column)

        vertical.children.forEach { child ->
            val layoutRenderer = makeComponentRenderer(child)
            column.child(layoutRenderer.build(context))
        }

        return column.build()
    }
}