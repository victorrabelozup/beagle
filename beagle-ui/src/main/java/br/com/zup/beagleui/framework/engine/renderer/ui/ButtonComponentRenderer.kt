package br.com.zup.beagleui.framework.engine.renderer.ui

import android.graphics.Color
import android.text.Layout
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.litho.Column
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.widget.Card
import com.facebook.litho.widget.Text
import com.facebook.yoga.YogaAlign
import com.facebook.yoga.YogaEdge
import com.facebook.yoga.YogaJustify

class ButtonComponentRenderer(
    private val button: Button
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        return createButton(context, button.text)
    }

    private fun createButton(context: ComponentContext, text: String): Component {
        return Column.create(context)
            .alignItems(YogaAlign.CENTER)
            .justifyContent(YogaJustify.CENTER)
            .child(
                Card.create(context)
                    .cardBackgroundColor(Color.GREEN)
                    .cornerRadiusDip(2.0f)
                    .elevationDip(2.0f)
                    .content(createButtonText(context, text))
                    .flexShrink(1.0f)
                    .alignSelf(YogaAlign.CENTER)
            ).build()
    }

    private fun createButtonText(context: ComponentContext, text: String): Component {
        return Text.create(context)
            .text(text)
            .textSizeDip(18.0f)
            .textColorRes(android.R.color.white)
            .textSizeSp(18.0f)
            .textAlignment(Layout.Alignment.ALIGN_CENTER)
            .alignSelf(YogaAlign.STRETCH)
            .paddingDip(YogaEdge.ALL, 8.0f)
            .build()
    }
}