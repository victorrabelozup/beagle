package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Stack

internal class ScrollViewRenderer(
    override val component: ScrollView,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<ScrollView>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val scrollDirection = component.scrollDirection ?: ScrollAxis.VERTICAL
        val scrollBarEnabled = component.scrollBarEnabled ?: true

        val stack = Stack(component.children)

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
