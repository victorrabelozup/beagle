package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.widget.ui.Button

internal class ButtonViewRenderer(
    private val button: Button,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makeButton(rootView.getContext()).apply {
            this.setData(button)
        }
    }
}
