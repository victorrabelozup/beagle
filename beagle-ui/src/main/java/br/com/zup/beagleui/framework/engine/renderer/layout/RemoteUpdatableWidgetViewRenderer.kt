package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.layout.RemoteUpdatableWidget

internal class RemoteUpdatableWidgetViewRenderer(
    private val remoteUpdatableWidget: RemoteUpdatableWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        return viewFactory.makeBeagleView(rootView.getContext()).apply {
            val initialState = remoteUpdatableWidget.initialState.toView(rootView)
            addView(initialState)
        }
    }
}