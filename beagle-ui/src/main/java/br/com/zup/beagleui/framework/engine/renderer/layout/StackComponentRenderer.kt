package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.addFlexToColumn
import br.com.zup.beagleui.framework.engine.renderer.makeComponentRenderer
import com.facebook.litho.Column
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.yoga.YogaPositionType

class StackComponentRenderer(
    private val stack: Stack
) : ComponentRenderer {
    override fun build(context: ComponentContext): Component {
        val lithoStack = Column.create(context)
            .positionType(YogaPositionType.ABSOLUTE)

        addFlexToColumn(stack.flex, lithoStack)

        stack.children.forEach { widget ->
            lithoStack.child(makeComponentRenderer(widget).build(context))
        }

        return lithoStack.build()
    }
}
