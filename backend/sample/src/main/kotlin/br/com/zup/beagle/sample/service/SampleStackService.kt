package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleStackService {
    fun creationStackView(): Screen {
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
            content = Stack(
                children = listOf(
                    Text(
                        "Text 1",
                        "DesignSystem.Text.helloWord"
                    ).applyFlex(
                        Flex(
                            margin = EdgeValue(
                                top = UnitValue(
                                    5.0,
                                    UnitType.REAL
                                )
                            )
                        )
                    ),
                    Text("Text 2", "DesignSystem.Text.helloWord"),
                    Text("Text 3", "DesignSystem.Text.helloWord")
                )
            )
        )

    }
}