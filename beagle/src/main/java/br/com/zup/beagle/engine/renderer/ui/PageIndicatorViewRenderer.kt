package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.PageIndicator

internal class PageIndicatorViewRenderer(
    override val widget: PageIndicator,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<PageIndicator>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makePageIndicator(rootView.getContext()).apply {
            setWidget(widget)
        }
    }
}
