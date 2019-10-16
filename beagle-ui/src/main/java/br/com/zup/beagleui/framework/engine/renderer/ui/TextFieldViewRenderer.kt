package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.EditText
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer

class TextFieldViewRenderer : UIViewRenderer {

    override fun build(context: Context): View {
        return EditText(context)
    }
}
