package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Button

internal class ButtonViewRenderer(
    private val button: Button,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeButton(context).apply {
            text = button.text
        }
    }
}
