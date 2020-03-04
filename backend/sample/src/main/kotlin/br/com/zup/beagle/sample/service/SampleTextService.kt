package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleTextService {
    fun creationTextView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Text",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Text",
                            message = "This widget will define a text view natively using the server driven " +
                                "information received through Beagle.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(

                    beagleText(
                        text = "hello world without style"
                    ),
                    beagleText(
                        text = "hello world with style",
                        style = "DesignSystem.Text.helloWord"
                    ),
                    beagleText(
                        text = "hello world with Appearance",
                        appearanceColor = "#4682b4"
                    ),
                    beagleText(
                        text = "hello world with style and Appearance",
                        style = "DesignSystem.Text.helloWord",
                        appearanceColor = "#40E0D0"
                    )
                )
            )
        )
    }

    private fun beagleText(
        text: String,
        style: String? = null,
        appearanceColor: String? = null
    ): Widget = Text(
        text = text,
        style = style
    ).applyFlex(
        flex = Flex(
            margin = EdgeValue(
                top = UnitValue(16.0, UnitType.REAL),
                start = UnitValue(16.0, UnitType.REAL),
                end = UnitValue(16.0, UnitType.REAL)
            )
        )
    ).applyAppearance(
        appearance = Appearance(
            backgroundColor = appearanceColor
        )
    )
}
