package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.core.Widget

internal class CustomWidgetViewRenderer(
    private val widget: Widget,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        val viewFactory = BeagleEnvironment.widgets[widget::class.java]
        return viewFactory?.make(rootView.getContext(), widget) ?: run {
            BeagleMessageLogs.logViewFactoryNotFoundForWidget(widget)
            viewRendererFactory.makeUndefinedViewRenderer().build(rootView)
        }
    }
}