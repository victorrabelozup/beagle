package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_STYLE
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleStackService {
    fun createStackView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle StackView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "StackView",
                            message = "Implements widgets on top of each other.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = Stack(
                children = listOf(
                    Text(
                        "Text 1",
                        SCREEN_TEXT_STYLE
                    ).applyFlex(
                        Flex(
                            margin = EdgeValue(
                                top = 5.unitReal()
                            )
                        )
                    ),
                    Text("Text 2", SCREEN_TEXT_STYLE),
                    Text("Text 3", SCREEN_TEXT_STYLE)
                )
            )
        )

    }
}