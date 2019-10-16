package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.layout.Horizontal

internal class HorizontalViewRenderer(
    private val horizontal: Horizontal,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : DirectionalViewRenderer(
    horizontal.children,
    horizontal.flex,
    viewRendererFactory,
    viewFactory
) {

    override fun getYogaFlexDirection(): FlexDirection {
        return if (horizontal.reversed) {
            FlexDirection.ROW_REVERSE
        } else {
            FlexDirection.ROW
        }
    }

}
