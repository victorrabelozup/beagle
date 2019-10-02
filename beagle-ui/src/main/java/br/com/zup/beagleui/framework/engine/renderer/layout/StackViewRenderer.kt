package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.mapper.FlexMapper
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Stack
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaPositionType
import com.facebook.yogalayout.YogaLayout

internal class StackViewRenderer(
    private val stack: Stack,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    yogaFactory: YogaFactory = YogaFactory(FlexMapper())
) : LayoutViewRenderer(viewRendererFactory, viewFactory, yogaFactory) {

    override fun build(context: Context): View {
        return yogaFactory.makeYogaLayout(context, stack.flex).apply {
            yogaNode.flexDirection = YogaFlexDirection.COLUMN
            yogaNode.positionType = YogaPositionType.ABSOLUTE
            addChildrenViews(stack.children, this)
        }
    }

    private fun addChildrenViews(children: List<Widget>, yogaLayout: YogaLayout) {
        children.forEach { widget ->
            yogaLayout.addView(viewRendererFactory.make(widget).build(yogaLayout.context))
        }
    }
}
