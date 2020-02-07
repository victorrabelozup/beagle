package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.engine.renderer.layout.FlexSingleWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormViewRenderer
import br.com.zup.beagle.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagle.engine.renderer.layout.LazyWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.TouchableViewRenderer
import br.com.zup.beagle.engine.renderer.layout.PageViewRenderer
import br.com.zup.beagle.engine.renderer.layout.ScreenViewRenderer
import br.com.zup.beagle.engine.renderer.layout.ScrollViewRenderer
import br.com.zup.beagle.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagle.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagle.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagle.widget.layout.ScreenWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Horizontal
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.layout.Vertical
import br.com.zup.beagle.widget.lazy.LazyWidget
import br.com.zup.beagle.widget.navigation.Touchable

internal class LayoutViewRendererFactory : AbstractViewRendererFactory {

    @Throws(IllegalArgumentException::class)
    override fun make(widget: Widget): ViewRenderer<*> {

        return when (widget) {
            is Container -> ContainerViewRenderer(widget)
            is FlexSingleWidget -> FlexSingleWidgetViewRenderer(widget)
            is ScreenWidget -> ScreenViewRenderer(widget)
            is Vertical -> VerticalViewRender(widget)
            is Horizontal -> HorizontalViewRenderer(widget)
            is Stack -> StackViewRenderer(widget)
            is Spacer -> SpacerViewRenderer(widget)
            is Touchable -> TouchableViewRenderer(widget)
            is Form -> FormViewRenderer(widget)
            is ScrollView -> ScrollViewRenderer(widget)
            is PageView -> PageViewRenderer(widget)
            is LazyWidget -> LazyWidgetViewRenderer(widget)
            else -> throw IllegalArgumentException("$widget is not a Layout Widget.")
        }
    }
}
