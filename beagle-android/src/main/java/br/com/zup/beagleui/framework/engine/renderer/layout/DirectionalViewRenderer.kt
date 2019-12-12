package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.Widget

internal abstract class DirectionalViewRenderer(
    private val children: List<Widget>,
    private val flex: Flex,
    viewRendererFactory: ViewRendererFactory,
    viewFactory: ViewFactory
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    abstract fun getYogaFlexDirection(): FlexDirection

    override fun build(rootView: RootView): View {
        val flexCopy = flex.copy(
            flexDirection = getYogaFlexDirection()
        )
        return viewFactory.makeBeagleFlexView(rootView.getContext(), flexCopy).apply {
            addChildrenViews(children, this, rootView)
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
