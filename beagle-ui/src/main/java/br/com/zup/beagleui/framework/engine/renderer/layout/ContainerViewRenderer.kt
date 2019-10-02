package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.mapper.FlexMapper
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaJustify

internal class ContainerViewRenderer(
    private val container: Container,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    yogaFactory: YogaFactory = YogaFactory(FlexMapper())
) : LayoutViewRenderer(viewRendererFactory, viewFactory, yogaFactory) {

    override fun build(context: Context): View {
        val container = yogaFactory.makeYogaLayout(context).apply {
            yogaNode.flexDirection = YogaFlexDirection.COLUMN
            yogaNode.justifyContent = YogaJustify.SPACE_BETWEEN
        }

        if (this.container.header != null) {
            container.addView(viewRendererFactory.make(this.container.header).build(context))
        }

        val contentView = viewRendererFactory.make(this.container.content).build(context)
        val scrollView = createScrollViewForView(context, contentView)
        container.addView(scrollView)

        if (this.container.footer != null) {
            container.addView(viewRendererFactory.make(this.container.footer).build(context))
        }

        return container
    }

    private fun createScrollViewForView(context: Context, view: View): View {
        val scrollView = viewFactory.makeScrollView(context).apply {
            addView(yogaFactory.makeYogaLayout(context).apply {
                addView(view)
            })
        }

        val scrollNode = yogaFactory.makeYogaNode().apply {
            flex = 1.0f
        }

        return yogaFactory.makeYogaLayout(context).apply {
            yogaNode.flex = 1.0f
            addView(scrollView, scrollNode)
        }
    }
}
