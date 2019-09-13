package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.makeComponentRenderer
import com.facebook.litho.Column
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.widget.VerticalScroll
import com.facebook.yoga.YogaAlign

class ContainerComponentRenderer(
    private val container: Container
) : ComponentRenderer {
    override fun build(context: ComponentContext): Component {
        val column = Column.create(context)
            .alignContent(YogaAlign.SPACE_BETWEEN)

        if (container.header != null) {
            column.child(makeComponentRenderer(container.header).build(context))
        }

        val contentComponent = makeComponentRenderer(container.content).build(context)
        val verticalScroll = createScrollViewForComponent(context, contentComponent)

        column.child(verticalScroll)

        if (container.footer != null) {
            column.child(makeComponentRenderer(container.footer).build(context))
        }

        return column.build()
    }

    private fun createScrollViewForComponent(context: ComponentContext, component: Component): Component {
        return VerticalScroll.create(context)
            .alignSelf(YogaAlign.FLEX_START)
            .heightPercent(100.0f)
            .fillViewport(true)
            .childComponent(component)
            .build()
    }
}
