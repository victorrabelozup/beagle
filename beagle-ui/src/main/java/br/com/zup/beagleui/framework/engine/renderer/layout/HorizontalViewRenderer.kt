package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory

internal class HorizontalViewRenderer(
    private val viewRendererFactory: ViewRendererFactory,
    private val horizontal: Horizontal
) : ViewRenderer {
    override fun build(context: Context): View {
        /*val row = Row.create(context)
            .reverse(horizontal.reversed)

        addFlexToRow(horizontal.flex, row)

        horizontal.children.forEach { child ->
            val layoutRenderer =
                make(child)
            row.child(layoutRenderer.build(context))
        }

        return row.build()*/

        return View(context)
    }
}
