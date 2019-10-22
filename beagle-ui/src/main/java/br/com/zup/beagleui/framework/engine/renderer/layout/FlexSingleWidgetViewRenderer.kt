package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget

internal class FlexSingleWidgetViewRenderer(
    private val flexSingleWidget: FlexSingleWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        return viewFactory.makeBeagleFlexView(context, flexSingleWidget.flex ?: Flex()).apply {
            addView(viewRendererFactory.make(flexSingleWidget.child).build(context))
        }
    }
}
