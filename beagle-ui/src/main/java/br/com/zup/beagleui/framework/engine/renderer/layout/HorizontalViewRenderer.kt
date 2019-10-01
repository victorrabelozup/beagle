package br.com.zup.beagleui.framework.engine.renderer.layout

import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import com.facebook.yoga.YogaFlexDirection

internal class HorizontalViewRenderer(
    private val horizontal: Horizontal,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    yogaFactory: YogaFactory = YogaFactory()
) : DirectionalViewRenderer(
    horizontal.children,
    horizontal.flex,
    viewRendererFactory,
    viewFactory,
    yogaFactory
) {

    override fun getYogaFlexDirection(): YogaFlexDirection {
        return if (horizontal.reversed) {
            YogaFlexDirection.ROW_REVERSE
        } else {
            YogaFlexDirection.ROW
        }
    }

}
