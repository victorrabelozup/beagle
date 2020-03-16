package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container

internal class ContainerViewRenderer(
    override val component: Container,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Container>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeBeagleFlexView(rootView.getContext(), component.flex ?: Flex())
            .apply {
                addChildren(this, rootView)
            }
    }

    private fun addChildren(beagleFlexView: BeagleFlexView, rootView: RootView) {
        component.children.forEach { child ->
            beagleFlexView.addServerDrivenComponent(child, rootView)
        }
    }
}
