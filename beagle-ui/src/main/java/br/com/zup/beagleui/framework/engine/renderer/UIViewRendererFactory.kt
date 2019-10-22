package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.engine.renderer.layout.BuildableWidgetViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import br.com.zup.beagleui.framework.widget.ui.Text

internal class UIViewRendererFactory : AbstractViewRendererFactory {

    override fun make(widget: Widget): ViewRenderer {
        return if (widget is NativeWidget) {
            when (widget) {
                is Button -> ButtonViewRenderer(widget)
                is Text -> TextViewRenderer(widget)
                is Image -> ImageViewRenderer(widget)
                is NetworkImage -> NetworkImageViewRenderer(widget)
                is ListView -> UndefinedViewRenderer()
                else -> UndefinedViewRenderer()
            }
        } else {
            BuildableWidgetViewRenderer(widget)
        }
    }
}