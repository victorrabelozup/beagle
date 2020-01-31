package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Expanded

internal class ExpandedViewRenderer(
    override val widget: Expanded,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Expanded>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0
        )

        return viewFactory.makeBeagleFlexView(rootView.getContext(), flex).apply {
            addView(viewRendererFactory.make(widget.child).build(rootView), flex)
        }
    }
}
