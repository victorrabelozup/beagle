package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.UiViewRenderer
import br.com.zup.beagleui.framework.widget.ui.Text

class TextViewRenderer(
    private val textWidget: Text
) : UiViewRenderer {

    override fun build(context: Context): View {
        return TextView(context).apply {
            text = textWidget.text
        }
    }
}
