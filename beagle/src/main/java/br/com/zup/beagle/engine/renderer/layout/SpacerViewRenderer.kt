package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Spacer

internal class SpacerViewRenderer(
    override val widget: Spacer,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Spacer>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val flex = Flex(
            size = Size(
                width = UnitValue(widget.size, UnitType.REAL),
                height = UnitValue(widget.size, UnitType.REAL)
            )
        )

        return viewFactory.makeBeagleFlexView(rootView.getContext(), flex)
    }
}
