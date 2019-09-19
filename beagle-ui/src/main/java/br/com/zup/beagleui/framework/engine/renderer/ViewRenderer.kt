package br.com.zup.beagleui.framework.engine.renderer

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.layout.ContainerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.HorizontalViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.SpacerViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.StackViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.layout.VerticalViewRender
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.engine.renderer.ui.ButtonRenderer
import br.com.zup.beagleui.framework.engine.renderer.ui.TextViewRenderer
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

internal fun makeViewRenderer(widget: Widget): ViewRenderer {
    return tryMakeViewComponent(widget) ?: tryMakeUIView(widget)
}

private fun tryMakeViewComponent(widget: Widget) : ViewRenderer? {
    return when (widget) {
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
        is Button -> ButtonRenderer(widget)
        is Text -> TextViewRenderer(widget)
        is Image -> UndefinedViewRenderer()
        is TextField -> UndefinedViewRenderer()
        is Toolbar -> UndefinedViewRenderer()
        is SelectView -> UndefinedViewRenderer()
        is ListView -> UndefinedViewRenderer()
        is DropDown -> UndefinedViewRenderer()
        else -> UndefinedViewRenderer()
    }
}
