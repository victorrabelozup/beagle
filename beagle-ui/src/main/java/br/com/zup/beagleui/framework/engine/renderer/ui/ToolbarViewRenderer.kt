package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import androidx.appcompat.widget.Toolbar as AndroidToolbar
import br.com.zup.beagleui.framework.widget.ui.Toolbar

class ToolbarViewRenderer(
    private val toolbar: Toolbar
) : UIViewRenderer {

    override fun build(context: Context): View {
        return AndroidToolbar(context).apply {
            title = toolbar.title
            setBackgroundColor(Color.RED)
        }
    }
}
