package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Size
import br.com.zup.beagleui.framework.widget.core.UnitType
import br.com.zup.beagleui.framework.widget.core.UnitValue

internal class SpacerViewRenderer(
    private val spacer: Spacer,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        val flex = Flex(
            size = Size(
                width = UnitValue(spacer.size, UnitType.REAL),
                height = UnitValue(spacer.size, UnitType.REAL)
            )
        )

        return viewFactory.makeBeagleFlexView(context, flex)
    }
}
