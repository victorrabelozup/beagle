package br.com.zup.beagle.sample.service

import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment
import org.springframework.stereotype.Service

@Service
class PageViewService {
    fun createPageView() = PageView(
        pageIndicator = PageIndicator(
            selectedColor = "#000000",
            unselectedColor = "#888888"
        ),
        pages = (1..3).map(this::createText)
    )

    private fun createText(i: Int) = Text("Page $i", alignment = TextAlignment.CENTER)
        .applyFlex(
            Flex(
                alignSelf = Alignment.CENTER,
                grow = 1.0
            )
        )
}