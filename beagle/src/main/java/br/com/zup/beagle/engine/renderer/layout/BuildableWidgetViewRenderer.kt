package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.ComposeWidget

internal class BuildableWidgetViewRenderer(
    override val widget: ComposeWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<ComposeWidget>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val buildResult = widget
        return viewRendererFactory.make(buildResult).build(rootView)
    }

}