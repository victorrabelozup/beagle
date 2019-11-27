package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexSingleWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FormViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.LazyWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.NavigatorViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StatefulWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.UpdatableWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.form.Form
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.lazy.LazyWidget
import br.com.zup.beagleui.framework.widget.navigation.Navigator

internal class LayoutViewRendererFactory : AbstractViewRendererFactory {

    @Throws(IllegalArgumentException::class)
    override fun make(widget: Widget) : ViewRenderer {
        return when (widget) {
            is FlexWidget -> FlexWidgetViewRenderer(widget)
            is FlexSingleWidget -> FlexSingleWidgetViewRenderer(widget)
            is StatefulWidget -> StatefulWidgetViewRenderer(widget)
            is UpdatableWidget -> UpdatableWidgetViewRenderer(widget)
            is Container -> ContainerViewRenderer(widget)
            is Vertical -> VerticalViewRender(widget)
            is Horizontal -> HorizontalViewRenderer(widget)
            is Stack -> StackViewRenderer(widget)
            is Spacer -> SpacerViewRenderer(widget)
            is Navigator -> NavigatorViewRenderer(widget)
            is Form -> FormViewRenderer(widget)
            is LazyWidget -> LazyWidgetViewRenderer(widget)
            else -> throw IllegalArgumentException("$widget is not a Layout Widget.")
        }
    }
}