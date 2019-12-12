package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.layout.ScrollAxis
import br.com.zup.beagleui.framework.widget.layout.ScrollView
import br.com.zup.beagleui.framework.widget.layout.Stack

internal class ScrollViewRenderer(
    private val widget: ScrollView,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val scrollDirection = widget.scrollDirection ?: ScrollAxis.VERTICAL
        val scrollBarEnabled = widget.scrollBarEnabled ?: true

        val stack = Stack(widget.children)

        return if (scrollDirection == ScrollAxis.HORIZONTAL) {
            viewFactory.makeHorizontalScrollView(rootView.getContext()).apply {
                isHorizontalScrollBarEnabled = scrollBarEnabled
                addView(viewRendererFactory.make(stack).build(rootView))
            }
        } else {
            viewFactory.makeScrollView(rootView.getContext()).apply {
                isVerticalScrollBarEnabled = scrollBarEnabled
                addView(viewRendererFactory.make(stack).build(rootView))
            }
        }
    }
}
