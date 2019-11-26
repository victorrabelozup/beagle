package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Text

internal class TextViewRenderer(
    private val textWidget: Text,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makeTextView(rootView.getContext()).apply {
            this.setData(textWidget)
        }
    }
}
