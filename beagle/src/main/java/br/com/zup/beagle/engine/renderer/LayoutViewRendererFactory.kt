package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.engine.renderer.layout.ScreenViewRenderer
import br.com.zup.beagle.engine.renderer.layout.ExpandedViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FlexSingleWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FlexWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormViewRenderer
import br.com.zup.beagle.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagle.engine.renderer.layout.LazyWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.NavigatorViewRenderer
import br.com.zup.beagle.engine.renderer.layout.PageViewRenderer
import br.com.zup.beagle.engine.renderer.layout.RemoteUpdatableWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.ScrollViewRenderer
import br.com.zup.beagle.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagle.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagle.engine.renderer.layout.StatefulWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.UpdatableWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagle.widget.ScreenWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.layout.Expanded
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.Horizontal
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.layout.RemoteUpdatableWidget
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.layout.StatefulWidget
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.layout.Vertical
import br.com.zup.beagle.widget.lazy.LazyWidget
import br.com.zup.beagle.widget.navigation.Navigator

internal class LayoutViewRendererFactory : AbstractViewRendererFactory {

    @Throws(IllegalArgumentException::class)
    override fun make(widget: Widget): ViewRenderer<*> {

        return when (widget) {
            is FlexWidget -> FlexWidgetViewRenderer(widget)
            is FlexSingleWidget -> FlexSingleWidgetViewRenderer(widget)
            is StatefulWidget -> StatefulWidgetViewRenderer(widget)
            is UpdatableWidget -> UpdatableWidgetViewRenderer(widget)
            is ScreenWidget -> ScreenViewRenderer(widget)
            is Vertical -> VerticalViewRender(widget)
            is Horizontal -> HorizontalViewRenderer(widget)
            is Stack -> StackViewRenderer(widget)
            is Spacer -> SpacerViewRenderer(widget)
            is Navigator -> NavigatorViewRenderer(widget)
            is Form -> FormViewRenderer(widget)
            is ScrollView -> ScrollViewRenderer(widget)
            is Expanded -> ExpandedViewRenderer(widget)
            is PageView -> PageViewRenderer(widget)
            is LazyWidget -> LazyWidgetViewRenderer(widget)
            is RemoteUpdatableWidget -> RemoteUpdatableWidgetViewRenderer(widget)
            else -> throw IllegalArgumentException("$widget is not a Layout Widget.")
        }
    }
}
