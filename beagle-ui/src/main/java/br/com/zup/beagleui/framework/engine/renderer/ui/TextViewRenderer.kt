package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.widget.ui.Text

class TextViewRenderer(
    private val textWidget: Text
) : UIViewRenderer {

    override fun build(context: Context): View {
        return TextView(context).apply {
            text = textWidget.text
        }
    }
}
