package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.UiViewRenderer

class UndefinedViewRenderer : UiViewRenderer {

    override fun build(context: Context): View {
        return TextView(context).apply {
            text = "undefined widget"
            setTextColor(Color.RED)
            setBackgroundColor(Color.YELLOW)
        }
    }
}
