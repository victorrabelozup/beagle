package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent

internal class ContainerViewRenderer(
    private val container: Container,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val flex = Flex(
            flexDirection = FlexDirection.COLUMN,
            justifyContent = JustifyContent.SPACE_BETWEEN
        )
        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)

        this.container.header?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        val contentView = viewRendererFactory.make(this.container.content).build(rootView)
        val scrollView = createScrollViewForView(rootView.getContext(), contentView)
        container.addView(scrollView)

        this.container.footer?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        return container
    }

    private fun createScrollViewForView(context: Context, view: View): View {
        val scrollView = viewFactory.makeScrollView(context).apply {
            addView(viewFactory.makeBeagleFlexView(context).apply {
                addView(view)
            })
        }

        val flex = Flex(
            grow = 1.0
        )

        return viewFactory.makeBeagleFlexView(context, flex).apply {
            addView(scrollView, flex)
        }
    }
}
