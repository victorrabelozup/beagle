package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.mapper.FlexMapper
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory

internal class SpacerViewRenderer(
    private val spacer: Spacer,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    yogaFactory: YogaFactory = YogaFactory(FlexMapper())
) : LayoutViewRenderer(viewRendererFactory, viewFactory, yogaFactory) {

    override fun build(context: Context): View {
        return yogaFactory.makeYogaLayout(context).apply {
            yogaNode.setWidth(spacer.size.toFloat())
            yogaNode.setHeight(spacer.size.toFloat())
        }
    }
}
