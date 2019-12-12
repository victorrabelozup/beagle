package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.layout.Expanded

internal class ExpandedViewRenderer(
    private val expanded: Expanded,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0
        )

        return viewFactory.makeBeagleFlexView(rootView.getContext(), flex).apply {
            addView(viewRendererFactory.make(expanded.child).build(rootView), flex)
        }
    }
}
