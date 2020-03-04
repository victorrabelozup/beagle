package br.com.zup.beagle.sample.compose

import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text

class CustomComposeComponent : ComposeComponent() {
    override fun build(): ServerDrivenComponent {
        return Container(
            children = listOf(
                buildTextBeagle(),
                buildImageBeagle()
            )
        ).applyFlex(
            flex = Flex(
                alignItems = Alignment.CENTER
            )
        )
    }

    private fun buildTextBeagle(): Widget {
        return Text(
            "Beagle framework"
        ).applyFlex(
            flex = Flex(
                alignItems = Alignment.CENTER,
                margin = EdgeValue(
                    top = UnitValue(16.0, UnitType.REAL),
                    bottom = UnitValue(16.0, UnitType.REAL)
                )
            )
        )
    }

    private fun buildImageBeagle(): Widget {
        return Image(
            "imageBeagle"
        )
    }
}