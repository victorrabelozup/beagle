package br.com.zup.beagleui.framework.engine.renderer

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexSingleWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.FlexWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import br.com.zup.beagleui.framework.widget.ui.Text

internal interface ViewRenderer {
    fun build(context: Context): View
}

internal abstract class LayoutViewRenderer(
    protected val viewRendererFactory: ViewRendererFactory,
    protected val viewFactory: ViewFactory
) : ViewRenderer

internal interface UIViewRenderer : ViewRenderer

internal class ViewRendererFactory {

    fun make(widget: Widget): ViewRenderer {
        return tryMakeViewLayout(widget) ?: tryMakeUIView(widget)
    }

    private fun tryMakeViewLayout(widget: Widget) : ViewRenderer? {
        return when (widget) {
            is FlexWidget -> FlexWidgetViewRenderer(widget)
            is FlexSingleWidget -> FlexSingleWidgetViewRenderer(widget)
            is Container -> ContainerViewRenderer(widget)
            is Vertical -> VerticalViewRender(widget)
            is Horizontal -> HorizontalViewRenderer(widget)
            is Stack -> StackViewRenderer(widget)
            is Spacer -> SpacerViewRenderer(widget)
            else -> null
        }
    }

    private fun tryMakeUIView(widget: Widget): ViewRenderer {
        return when (widget) {
            is Button -> ButtonViewRenderer(widget)
            is Text -> TextViewRenderer(widget)
            is Image -> ImageViewRenderer(widget)
            is NetworkImage -> NetworkImageViewRenderer(widget)
            is ListView -> UndefinedViewRenderer()
            else -> UndefinedViewRenderer()
        }
    }
}
