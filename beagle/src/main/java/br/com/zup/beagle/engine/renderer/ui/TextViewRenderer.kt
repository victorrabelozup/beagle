package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.Text

internal class TextViewRenderer(
    override val widget: Text,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<Text>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeTextView(rootView.getContext()).apply {
            this.setData(widget)
        }
    }
}
