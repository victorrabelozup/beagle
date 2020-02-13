package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection

internal abstract class DirectionalViewRenderer<T : ServerDrivenComponent>(
    private val children: List<ServerDrivenComponent>,
    private val flex: Flex,
    viewRendererFactory: ViewRendererFactory,
    viewFactory: ViewFactory
) : LayoutViewRenderer<T>(viewRendererFactory, viewFactory) {

    abstract fun getYogaFlexDirection(): FlexDirection

    override fun buildView(rootView: RootView): View {
        val flexCopy = flex.copy(
            flexDirection = getYogaFlexDirection()
        )
        return viewFactory.makeBeagleFlexView(rootView.getContext(), flexCopy).apply {
            addChildrenViews(children, this, rootView)
        }
    }

    private fun addChildrenViews(
        children: List<ServerDrivenComponent>,
        beagleFlexView: BeagleFlexView,
        rootView: RootView
    ) {
        children.forEach { widget ->
            beagleFlexView.addView(viewRendererFactory.make(widget).build(rootView))
        }
    }
}
