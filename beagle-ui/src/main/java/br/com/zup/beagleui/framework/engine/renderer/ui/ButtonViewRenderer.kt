package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UiViewRenderer
import android.widget.Button as AndroidButton
import br.com.zup.beagleui.framework.widget.ui.Button

class ButtonViewRenderer(
    private val button: Button
) : UiViewRenderer {

    override fun build(context: Context): View {
        return AndroidButton(context).apply {
            text = button.text
        }
    }
}
