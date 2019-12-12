package br.com.zup.beagleui.framework.engine.renderer

import android.view.View
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagleui.framework.widget.core.Widget

internal interface ViewRenderer {
    fun build(rootView: RootView): View
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

    fun makeUndefinedViewRenderer(): ViewRenderer = UndefinedViewRenderer()
}
