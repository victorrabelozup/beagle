package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.Expanded

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

        val expanded = Expanded(this.container.content)
        val contentView = viewRendererFactory.make(expanded).build(rootView)
        container.addView(contentView)

        this.container.footer?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        return container
    }
}
