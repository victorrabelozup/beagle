package br.com.zup.beagleui.framework.engine.renderer.ui

import br.com.zup.beagleui.framework.widget.ui.Text
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.widget.Text as LithoText

class TextComponentRenderer(
    private val text: Text
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        return LithoText.create(context)
            .text(text.text)
            .textSizeDip(18.0f)
            .textSizeSp(18.0f)
            .build()
    }
}