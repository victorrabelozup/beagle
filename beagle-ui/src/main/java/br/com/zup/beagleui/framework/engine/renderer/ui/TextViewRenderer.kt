package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Text

internal class TextViewRenderer(
    private val textWidget: Text,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeTextView(context).apply {
            text = textWidget.text
        }
    }
}
