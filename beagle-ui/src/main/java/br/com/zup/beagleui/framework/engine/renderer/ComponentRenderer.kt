package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalComponentRender
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextComponentRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedComponentRenderer
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.DropDown
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.SelectView
import br.com.zup.beagleui.framework.widget.ui.Text
import br.com.zup.beagleui.framework.widget.ui.TextField
import br.com.zup.beagleui.framework.widget.ui.Toolbar

import com.facebook.litho.Component
import com.facebook.litho.ComponentContext

internal interface ComponentRenderer {
    fun build(context: ComponentContext): Component
}

internal fun makeComponentRenderer(widget: Widget): ComponentRenderer {
    return tryMakeLayoutComponent(widget) ?: tryMakeUIComponent(widget)
}

private fun tryMakeLayoutComponent(widget: Widget) : ComponentRenderer? {
    return when (widget) {
        is Container -> ContainerComponentRenderer(widget)
        is Vertical -> VerticalComponentRender(widget)
        is Horizontal -> HorizontalComponentRenderer(widget)
        is Stack -> StackComponentRenderer(widget)
        is Spacer -> SpacerComponentRenderer(widget)
        else -> null
    }
}

private fun tryMakeUIComponent(widget: Widget): ComponentRenderer {
    return when (widget) {
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
