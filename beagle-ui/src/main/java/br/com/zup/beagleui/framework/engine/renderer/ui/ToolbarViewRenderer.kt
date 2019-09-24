package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer

class ToolbarViewRenderer : ViewRenderer {

    override fun build(context: Context): View {
        return Toolbar(context)
    }
}
