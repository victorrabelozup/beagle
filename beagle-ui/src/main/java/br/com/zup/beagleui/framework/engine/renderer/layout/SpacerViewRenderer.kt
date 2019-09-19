package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer

class SpacerViewRenderer(
    private val spacer: Spacer
) : ViewRenderer {

    override fun build(context: Context): View {
        /*return Row.create(context)
            .widthDip(spacer.size.toFloat())
            .heightDip(spacer.size.toFloat())
            .build()*/
        return View(context)
    }
}
