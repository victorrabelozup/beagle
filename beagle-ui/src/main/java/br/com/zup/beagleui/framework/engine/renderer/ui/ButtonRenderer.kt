package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.Button as AndroidButton
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer

class ButtonRenderer(
    private val button: Button
) : ViewRenderer {

    override fun build(context: Context): View {
        return AndroidButton(context).apply {
            text = button.text
        }
    }
}
