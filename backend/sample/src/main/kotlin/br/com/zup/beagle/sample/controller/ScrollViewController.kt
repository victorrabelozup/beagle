package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ScrollViewController {

    @RequestMapping("/scrollView")
    fun getScrollView(): ServerDrivenComponent {
        return ScrollView(
            scrollBarEnabled = false,
            scrollDirection = ScrollAxis.HORIZONTAL,
            children = listOf(
                Text("Text").applyAppearance(Appearance(backgroundColor = "#888888"))
                    .applyFlex(
                        Flex(
                            margin = EdgeValue(
                                left = UnitValue(30.0, UnitType.REAL)
                            )
                        )
                    ),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text"),
                Text("Text")
            )

        )
    }
}