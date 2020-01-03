package br.com.zup.beagle.engine.renderer.layout

import android.graphics.Color
import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.FlexSingleWidget

internal class FlexSingleWidgetViewRenderer(
    private val flexSingleWidget: FlexSingleWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val flex = flexSingleWidget.flex ?: Flex()
        return viewFactory.makeBeagleFlexView(
            rootView.getContext(),
            flex
        ).apply {
            addView(viewRendererFactory.make(flexSingleWidget.child).build(rootView), flex)
            flexSingleWidget.appearance?.backgroundColor?.let {
                setBackgroundColor(Color.parseColor(it))
            }
        }
    }
}
