package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.FlexWidget

internal class FlexWidgetViewRenderer(
    private val flexWidget: FlexWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        return viewFactory.makeBeagleFlexView(rootView.getContext(), flexWidget.flex ?: Flex()).apply {
            addChildren(rootView, this)
        }
    }

    private fun addChildren(rootView: RootView, beagleFlexView: BeagleFlexView) {
        flexWidget.children.forEach {
            beagleFlexView.addView(viewRendererFactory.make(it).build(rootView))
        }
    }
}
