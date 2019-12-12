package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.widget.ui.Button

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
