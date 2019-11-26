package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import androidx.core.widget.TextViewCompat
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.ui.Button

internal class ButtonViewRenderer(
    private val button: Button,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makeButton(rootView.getContext()).apply {
            text = button.text
            BeagleEnvironment.theme?.let {
                val buttonAppearance = it.buttonTheme.buttonTextAppearance(button.style)
                val buttonBackground = it.buttonTheme.buttonBackground(button.style)

                setBackgroundResource(buttonBackground)
                TextViewCompat.setTextAppearance(this, buttonAppearance)
            }
        }
    }
}
