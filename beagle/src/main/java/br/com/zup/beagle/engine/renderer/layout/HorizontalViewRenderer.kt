package br.com.zup.beagle.engine.renderer.layout

import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Horizontal

internal class HorizontalViewRenderer(
    override val component: Horizontal,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : DirectionalViewRenderer<Horizontal>(
    component.children,
    Flex(),
    viewRendererFactory,
    viewFactory
) {

    override fun getYogaFlexDirection(): FlexDirection {
        return if (component.reversed == true) {
            FlexDirection.ROW_REVERSE
        } else {
            FlexDirection.ROW
        }
    }

}
