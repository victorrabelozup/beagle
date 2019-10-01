package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yogalayout.YogaLayout

internal abstract class DirectionalViewRenderer(
    private val children: List<Widget>,
    private val flex: Flex,
    viewRendererFactory: ViewRendererFactory,
    viewFactory: ViewFactory,
    yogaFactory: YogaFactory
) : LayoutViewRenderer(viewRendererFactory, viewFactory, yogaFactory) {

    abstract fun getYogaFlexDirection(): YogaFlexDirection

    override fun build(context: Context): View {
        return yogaFactory.makeYogaLayout(context, flex).apply {
            yogaNode.flexDirection = getYogaFlexDirection()
            addChildrenViews(children, this)
        }
    }

    private fun addChildrenViews(children: List<Widget>, yogaLayout: YogaLayout) {
        children.forEach { widget ->
            yogaLayout.addView(viewRendererFactory.make(widget).build(yogaLayout.context))
        }
    }
}
