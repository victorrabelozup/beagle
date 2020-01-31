package br.com.zup.beagle.engine.renderer.layout

import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Vertical

internal class VerticalViewRender(
    override val widget: Vertical,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : DirectionalViewRenderer<Vertical>(
    widget.children,
    Flex(),
    viewRendererFactory,
    viewFactory
) {

    override fun getYogaFlexDirection(): FlexDirection {
        return if (widget.reversed == true) {
            FlexDirection.COLUMN_REVERSE
        } else {
            FlexDirection.COLUMN
        }
    }
}
