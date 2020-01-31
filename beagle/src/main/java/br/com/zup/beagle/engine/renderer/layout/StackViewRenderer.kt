package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.FlexPositionType
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Stack

internal class StackViewRenderer(
    override val widget: Stack,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Stack>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val flex = Flex(
            flexDirection = FlexDirection.COLUMN,
            positionType = FlexPositionType.ABSOLUTE
        )
        return viewFactory.makeBeagleFlexView(rootView.getContext(), flex).apply {
            addChildrenViews(widget.children, this, rootView)
        }
    }

    private fun addChildrenViews(
        children: List<Widget>,
        beagleFlexView: BeagleFlexView,
        rootView: RootView
    ) {
        children.forEach { widget ->
            beagleFlexView.addView(viewRendererFactory.make(widget).build(rootView))
        }
    }
}
