package br.com.zup.beagle.sample.widget

import br.com.zup.beagle.widget.core.ComposeWidget
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class CustomWidget : ComposeWidget {
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