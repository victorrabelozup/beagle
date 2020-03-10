package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.STEEL_BLUE
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_STYLE
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleTextService {
    fun createTextView(): Screen {
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
            child = Container(
                children = listOf(

                    beagleText(
                        text = "hello world without style"
                    ),
                    beagleText(
                        text = "hello world with style",
                        style = SCREEN_TEXT_STYLE
                    ),
                    beagleText(
                        text = "hello world with Appearance",
                        appearanceColor = STEEL_BLUE
                    ),
                    beagleText(
                        text = "hello world with style and Appearance",
                        style = SCREEN_TEXT_STYLE,
                        appearanceColor = STEEL_BLUE
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
                top = 16.unitReal(),
                start = 16.unitReal(),
                end = 16.unitReal()
            )
        )
    ).applyAppearance(
        appearance = Appearance(
            backgroundColor = appearanceColor
        )
    )
}
