package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.layout.Vertical

internal class VerticalViewRender(
    private val vertical: Vertical,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : DirectionalViewRenderer(
    vertical.children,
    vertical.flex,
    viewRendererFactory,
    viewFactory
) {

    override fun getYogaFlexDirection(): FlexDirection {
        return if (vertical.reversed) {
            FlexDirection.COLUMN_REVERSE
        } else {
            FlexDirection.COLUMN
        }
    }
}
