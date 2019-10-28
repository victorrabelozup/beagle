package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import androidx.core.widget.TextViewCompat
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.ui.Button

internal class ButtonViewRenderer(
    private val button: Button,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeButton(context).apply {
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
