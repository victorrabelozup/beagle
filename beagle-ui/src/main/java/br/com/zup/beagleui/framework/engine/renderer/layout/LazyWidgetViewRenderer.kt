package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.lazy.LazyWidget

internal class LazyWidgetViewRenderer(
    private val lazyWidget: LazyWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        return viewFactory.makeBeagleView(rootView.getContext()).apply {
            val initialState = lazyWidget.initialState.toView(rootView)
            addView(initialState)
            updateView(rootView, lazyWidget.url, initialState)
        }
    }
}