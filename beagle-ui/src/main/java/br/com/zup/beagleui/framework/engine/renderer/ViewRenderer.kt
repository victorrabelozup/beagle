package br.com.zup.beagleui.framework.engine.renderer

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextFieldViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.ToolbarViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
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

internal interface ViewRenderer {
    fun build(context: Context): View
}

internal class ViewRendererFactory {

    fun make(widget: Widget): ViewRenderer {
        return tryMakeViewLayout(widget) ?: tryMakeUIView(widget)
    }

    private fun tryMakeViewLayout(widget: Widget) : ViewRenderer? {
        return when (widget) {
            is Container -> ContainerViewRenderer(this, widget)
            is Vertical -> VerticalViewRender(this, widget)
            is Horizontal -> HorizontalViewRenderer(this, widget)
            is Stack -> StackViewRenderer(this, widget)
            is Spacer -> SpacerViewRenderer(widget)
            else -> null
        }
    }

    private fun tryMakeUIView(widget: Widget): ViewRenderer {
        return when (widget) {
            is Button -> ButtonViewRenderer(widget)
            is Text -> TextViewRenderer(widget)
            is Image -> ImageViewRenderer(widget)
            is TextField -> TextFieldViewRenderer()
            is Toolbar -> ToolbarViewRenderer()
            is SelectView -> UndefinedViewRenderer()
            is ListView -> UndefinedViewRenderer()
            is DropDown -> UndefinedViewRenderer()
            else -> UndefinedViewRenderer()
        }
    }
}
