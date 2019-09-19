package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.ui.DropDown
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer

class DropDownViewRenderer(
    private val dropDown: DropDown
) : ViewRenderer {

    override fun build(context: Context): View {
        return View(context)
    }
}
