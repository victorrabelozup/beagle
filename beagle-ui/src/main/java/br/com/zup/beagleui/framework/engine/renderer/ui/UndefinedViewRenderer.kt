package br.com.zup.beagleui.framework.engine.renderer.ui

import android.graphics.Color
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.setup.Environment
import br.com.zup.beagleui.framework.view.ViewFactory

internal class UndefinedViewRenderer(
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return if (BeagleEnvironment.environment == Environment.DEBUG) {
            viewFactory.makeTextView(rootView.getContext()).apply {
                text = "undefined widget"
                setTextColor(Color.RED)
                setBackgroundColor(Color.YELLOW)
            }
        } else {
            viewFactory.makeView(rootView.getContext())
        }
    }
}
