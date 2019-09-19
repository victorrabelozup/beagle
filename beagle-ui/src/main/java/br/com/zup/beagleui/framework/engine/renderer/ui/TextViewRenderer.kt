package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.TextView
import br.com.zup.beagleui.framework.widget.ui.Text
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer

class TextViewRenderer(
    private val textWidget: Text
) : ViewRenderer {

    override fun build(context: Context): View {
        return TextView(context).apply {
            text = textWidget.text
        }
    }
}
