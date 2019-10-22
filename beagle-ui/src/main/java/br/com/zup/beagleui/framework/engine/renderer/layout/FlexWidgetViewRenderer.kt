package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.FlexWidget

internal class FlexWidgetViewRenderer(
    private val flexWidget: FlexWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        return viewFactory.makeBeagleFlexView(context, flexWidget.flex ?: Flex()).apply {
            addChildren(this)
        }
    }

    private fun addChildren(beagleFlexView: BeagleFlexView) {
        flexWidget.children.forEach {
            beagleFlexView.addView(viewRendererFactory.make(it).build(beagleFlexView.context))
        }
    }
}
