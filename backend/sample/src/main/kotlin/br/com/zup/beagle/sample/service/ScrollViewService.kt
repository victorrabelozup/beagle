package br.com.zup.beagle.sample.service

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.LIGHT_GREY
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class ScrollViewService {
    fun createScrollView() = ScrollView(
        scrollBarEnabled = false,
        scrollDirection = ScrollAxis.HORIZONTAL,
        children = listOf(
            createText().applyAppearance(Appearance(backgroundColor = LIGHT_GREY))
                .applyFlex(
                    Flex(
                        margin = EdgeValue(
                            left = 30.unitReal()
                        )
                    )
                )
        ) + List(20) { createText() }
    )

    private fun createText() = Text("Text")
}