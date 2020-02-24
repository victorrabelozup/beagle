package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import android.view.ViewGroup
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView

internal class ScrollViewRenderer(
    override val component: ScrollView,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<ScrollView>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val scrollDirection = component.scrollDirection ?: ScrollAxis.VERTICAL
        val scrollBarEnabled = component.scrollBarEnabled ?: true

        val flexDirection = if (scrollDirection == ScrollAxis.VERTICAL) {
            FlexDirection.COLUMN
        } else {
            FlexDirection.ROW
        }

        val flex = Flex(flexDirection = flexDirection)

        return if (scrollDirection == ScrollAxis.HORIZONTAL) {
            viewFactory.makeHorizontalScrollView(rootView.getContext()).apply {
                isHorizontalScrollBarEnabled = scrollBarEnabled
                addChildrenViews(this, component.children, rootView, flex)
            }
        } else {
            viewFactory.makeScrollView(rootView.getContext()).apply {
                isVerticalScrollBarEnabled = scrollBarEnabled
                addChildrenViews(this, component.children, rootView, flex)
            }
        }
    }

    private fun addChildrenViews(
        scrollView: ViewGroup,
        children: List<ServerDrivenComponent>,
        rootView: RootView,
        flex: Flex
    ) {
        val viewGroup = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)
        children.forEach { component ->
            viewGroup.addServerDrivenComponent(component, rootView)
        }
        scrollView.addView(viewGroup)
    }
}
