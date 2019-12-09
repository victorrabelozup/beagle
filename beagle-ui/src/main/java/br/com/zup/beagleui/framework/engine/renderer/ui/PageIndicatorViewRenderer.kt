package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.PageIndicator

internal class PageIndicatorViewRenderer(
    private val widget: PageIndicator,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makePageIndicator(rootView.getContext()).apply {
            setWidget(widget)
        }
    }
}
