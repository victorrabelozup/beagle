package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class PageViewController {

    @RequestMapping("/pageView")
    fun getPageView() = PageView(
        pageIndicator = PageIndicator(
            selectedColor = "#000000",
            unselectedColor = "#888888"
        ),
        pages = listOf(
            Text("Page 1", alignment = TextAlignment.CENTER).applyFlex(
                Flex(
                    alignSelf = Alignment.CENTER,
                    grow = 1.0
                )
            ),
            Text("Page 2", alignment = TextAlignment.CENTER).applyFlex(
                Flex(
                    alignSelf = Alignment.CENTER,
                    grow = 1.0
                )
            ),
            Text("Page 3", alignment = TextAlignment.CENTER).applyFlex(
                Flex(
                    alignSelf = Alignment.CENTER,
                    grow = 1.0
                )
            )
        )
    )
}
