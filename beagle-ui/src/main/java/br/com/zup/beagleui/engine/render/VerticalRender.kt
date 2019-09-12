package br.com.zup.beagleui.engine.render

import br.com.zup.beagleui.engine.framework.layout.Vertical
import com.facebook.litho.Column
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext

class VerticalRender : LayoutRenderer<Vertical> {

    override fun build(context: ComponentContext, layout: Vertical): Component {
        val column = Column.create(context)

        layout.children.forEach { child ->
//            column.
        }

        return column.build()
    }
}