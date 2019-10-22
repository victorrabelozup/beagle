package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexSingleWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical

internal class LayoutViewRendererFactory : AbstractViewRendererFactory {

    @Throws(IllegalArgumentException::class)
    override fun make(widget: Widget) : ViewRenderer {
        return when (widget) {
            is FlexWidget -> FlexWidgetViewRenderer(widget)
            is FlexSingleWidget -> FlexSingleWidgetViewRenderer(widget)
            is Container -> ContainerViewRenderer(widget)
            is Vertical -> VerticalViewRender(widget)
            is Horizontal -> HorizontalViewRenderer(widget)
            is Stack -> StackViewRenderer(widget)
            is Spacer -> SpacerViewRenderer(widget)
            else -> throw IllegalArgumentException("$widget is not a Layout Widget.")
        }
    }
}