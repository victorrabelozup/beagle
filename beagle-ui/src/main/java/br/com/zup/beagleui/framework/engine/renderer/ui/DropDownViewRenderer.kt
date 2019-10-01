package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UiViewRenderer
import br.com.zup.beagleui.framework.widget.ui.DropDown

class DropDownViewRenderer(
    private val dropDown: DropDown
) : UiViewRenderer {

    override fun build(context: Context): View {
        return View(context)
    }
}
