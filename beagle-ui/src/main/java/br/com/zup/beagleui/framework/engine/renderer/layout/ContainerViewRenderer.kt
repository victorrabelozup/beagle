package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.ScrollView
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.makeViewRenderer
import com.facebook.yogalayout.VirtualYogaLayout

class ContainerViewRenderer(
    private val container: Container
) : ViewRenderer {
    override fun build(context: Context): View {
        val container = VirtualYogaLayout(context).apply {

        }

        if (this.container.header != null) {
            container.addView(makeViewRenderer(this.container.header).build(context))
        }

        val contentView = makeViewRenderer(this.container.content).build(context)
        val scrollView = createScrollViewForView(context, contentView)

        container.addView(scrollView)

        if (this.container.footer != null) {
            container.addView(makeViewRenderer(this.container.footer).build(context))
        }

        return container
    }

    private fun createScrollViewForView(context: Context, view: View): View {
        return ScrollView(context).apply { 
            addView(view, ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT
            ))
        }
    }
}
