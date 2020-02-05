package br.com.zup.beagle.engine.renderer

import android.view.View
import br.com.zup.beagle.utils.applyAppearance
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Widget

internal abstract class ViewRenderer<T : Widget> {
    abstract val widget: T

    fun build(rootView: RootView): View {
        val builtView = buildView(rootView)
        afterBuildView(builtView, widget)
        return builtView
    }

    abstract fun buildView(rootView: RootView): View

    private fun afterBuildView(
        view: View,
        widget: T
    ) {
        view.applyAppearance(widget)
    }
}

internal abstract class LayoutViewRenderer<T : Widget>(
    protected val viewRendererFactory: ViewRendererFactory,
    protected val viewFactory: ViewFactory
) : ViewRenderer<T>()

internal abstract class UIViewRenderer<T : Widget> : ViewRenderer<T>()

internal interface AbstractViewRendererFactory {
    fun make(widget: Widget): ViewRenderer<*>
}

internal class ViewRendererFactory(
    private val layout: LayoutViewRendererFactory = LayoutViewRendererFactory(),
    private val ui: UIViewRendererFactory = UIViewRendererFactory()
) : AbstractViewRendererFactory {

    override fun make(widget: Widget): ViewRenderer<*> {
        return try {
            layout.make(widget)
        } catch (exception: IllegalArgumentException) {
            ui.make(widget)
        }
    }
}
