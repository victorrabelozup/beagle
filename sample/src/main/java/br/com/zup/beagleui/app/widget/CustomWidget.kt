package br.com.zup.beagleui.app.widget

import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text

class CustomWidget : Widget {
    override fun build(): Widget = FlexWidget(
        flex = Flex(
            justifyContent = JustifyContent.CENTER
        ),
        children = listOf(
            Button("Text 1"),
            Text("Text 1")
        )
    )
}