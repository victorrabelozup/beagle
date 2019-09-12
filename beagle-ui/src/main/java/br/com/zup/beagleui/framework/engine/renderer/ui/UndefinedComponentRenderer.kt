package br.com.zup.beagleui.framework.engine.renderer.ui

import android.graphics.Color
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.widget.Text

class UndefinedComponentRenderer : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        return Text.create(context)
            .text("undefined component")
            .textSizeDip(18.0f)
            .textSizeSp(18.0f)
            .textColor(Color.RED)
            .backgroundColor(Color.YELLOW)
            .build()
    }
}