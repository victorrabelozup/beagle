package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.FlexPositionType
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Stack

internal class StackViewRenderer(
    private val stack: Stack,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        val flex = Flex(
            flexDirection = FlexDirection.COLUMN,
            positionType = FlexPositionType.ABSOLUTE
        )
        return viewFactory.makeBeagleFlexView(context, flex).apply {
            addChildrenViews(stack.children, this)
        }
    }

    private fun addChildrenViews(children: List<Widget>, beagleFlexView: BeagleFlexView) {
        children.forEach { widget ->
            beagleFlexView.addView(viewRendererFactory.make(widget).build(beagleFlexView.context))
        }
    }
}
