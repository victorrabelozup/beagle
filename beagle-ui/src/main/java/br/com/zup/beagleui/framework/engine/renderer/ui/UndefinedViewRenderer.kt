package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.view.ViewFactory

internal class UndefinedViewRenderer(
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeTextView(context).apply {
            text = "undefined widget"
            setTextColor(Color.RED)
            setBackgroundColor(Color.YELLOW)
        }
    }
}
