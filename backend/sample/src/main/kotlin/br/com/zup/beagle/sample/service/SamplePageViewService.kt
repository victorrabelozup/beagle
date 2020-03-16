package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.constants.BLACK
import br.com.zup.beagle.sample.constants.LIGHT_GREY
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment
import org.springframework.stereotype.Service

@Service
class SamplePageViewService {
    fun createPageView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle PageView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "PageView",
                            message = "This component is a specialized container " +
                                "to hold pages (views) that may be swiped.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = PageView(
                pageIndicator = PageIndicator(
                    selectedColor = BLACK,
                    unselectedColor = LIGHT_GREY
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
        )

    }
}

