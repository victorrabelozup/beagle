package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory

internal class VerticalViewRender(
    private val viewRendererFactory: ViewRendererFactory,
    private val vertical: Vertical
) : ViewRenderer {

    override fun build(context: Context): View {
        /*val column = Column.create(context)
            .reverse(vertical.reversed)

        vertical.children.forEach { child ->
            val layoutRenderer = make(child)
            column.child(layoutRenderer.build(context))
        }

        return column.build()*/
        return View(context)
    }
}
