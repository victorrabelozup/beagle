package br.com.zup.beagle.engine.renderer

import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.utils.AccessibilitySetup
import br.com.zup.beagle.utils.applyAppearance
import br.com.zup.beagle.view.ViewFactory

internal abstract class ViewRenderer<T : ServerDrivenComponent>(
    private val accessibilitySetup: AccessibilitySetup = AccessibilitySetup()
) {
    abstract val component: T

    fun build(rootView: RootView): View {
        val builtView = buildView(rootView)
        afterBuildView(builtView, component)
        return builtView
    }

    abstract fun buildView(rootView: RootView): View

    private fun afterBuildView(
        view: View,
        widget: T
    ) {
        view.applyAppearance(widget)
        accessibilitySetup.applyAccessibility(view, widget)
    }
}

internal abstract class LayoutViewRenderer<T : ServerDrivenComponent>(
    protected val viewRendererFactory: ViewRendererFactory,
    protected val viewFactory: ViewFactory
) : ViewRenderer<T>()

internal abstract class UIViewRenderer<T : ServerDrivenComponent> : ViewRenderer<T>()

internal interface AbstractViewRendererFactory {
    fun make(component: ServerDrivenComponent): ViewRenderer<*>
}

internal class ViewRendererFactory(
    private val layout: LayoutViewRendererFactory = LayoutViewRendererFactory(),
    private val ui: UIViewRendererFactory = UIViewRendererFactory()
) : AbstractViewRendererFactory {

    override fun make(component: ServerDrivenComponent): ViewRenderer<*> {
        return try {
            layout.make(component)
        } catch (exception: IllegalArgumentException) {
            ui.make(component)
        }
    }
}
