package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.*
import br.com.zup.beagleui.framework.widget.ui.*
import br.com.zup.beagleui.framework.engine.renderer.layout.*
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext

internal interface ComponentRenderer {
    fun build(context: ComponentContext): Component
}

internal fun makeComponentRenderer(widget: Widget): ComponentRenderer {
    return when (widget) {
        // Layout
        is Container -> ContainerComponentRenderer(widget)
        is Vertical -> VerticalComponentRender(widget)
        is Horizontal -> HorizontalComponentRenderer(widget)
        is Stack -> StackComponentRenderer(widget)
        is Spacer -> SpacerComponentRenderer(widget)
        // UI
        is Button -> ButtonComponentRenderer(widget)
        is Text -> TextComponentRenderer(widget)
        is Image -> UndefinedComponentRenderer()
        is TextField -> UndefinedComponentRenderer()
        is Toolbar -> UndefinedComponentRenderer()
        is SelectView -> UndefinedComponentRenderer()
        is ListView -> UndefinedComponentRenderer()
        is DropDown -> UndefinedComponentRenderer()
        else -> UndefinedComponentRenderer()
    }
}