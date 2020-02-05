package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.widget.core.WidgetView

internal class WidgetViewRenderer(override val widget: WidgetView) : UIViewRenderer<WidgetView>() {
    override fun buildView(rootView: RootView): View {
        return widget.toView(rootView.getContext())
    }
}