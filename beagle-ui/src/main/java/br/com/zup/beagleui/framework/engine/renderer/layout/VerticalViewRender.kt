package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.layout.Vertical
import com.facebook.yoga.YogaFlexDirection

internal class VerticalViewRender(
    private val vertical: Vertical,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    yogaFactory: YogaFactory = YogaFactory()
) : DirectionalViewRenderer(
    vertical.children,
    vertical.flex,
    viewRendererFactory,
    viewFactory,
    yogaFactory
) {

    override fun getYogaFlexDirection(): YogaFlexDirection {
        return if (vertical.reversed) {
            YogaFlexDirection.COLUMN_REVERSE
        } else {
            YogaFlexDirection.COLUMN
        }
    }
}
