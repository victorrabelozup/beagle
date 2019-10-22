package br.com.zup.beagleui.framework.engine.renderer

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget

internal interface ViewRenderer {
    fun build(context: Context): View
}

internal abstract class LayoutViewRenderer(
    protected val viewRendererFactory: ViewRendererFactory,
    protected val viewFactory: ViewFactory
) : ViewRenderer

internal interface UIViewRenderer : ViewRenderer

internal interface AbstractViewRendererFactory {
    fun make(widget: Widget): ViewRenderer
}

internal class ViewRendererFactory(
    private val layout: LayoutViewRendererFactory = LayoutViewRendererFactory(),
    private val ui: UIViewRendererFactory = UIViewRendererFactory()
) : AbstractViewRendererFactory {

    override fun make(widget: Widget): ViewRenderer {
        return try {
            layout.make(widget)
        } catch (exception: IllegalArgumentException) {
            ui.make(widget)
        }
    }
}
