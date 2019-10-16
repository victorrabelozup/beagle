package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.widget.ui.DropDown

class DropDownViewRenderer(
    private val dropDown: DropDown
) : UIViewRenderer {

    override fun build(context: Context): View {
        return View(context)
    }
}
