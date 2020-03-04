package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import org.springframework.stereotype.Service

@Service
class SampleButtonService {
    fun creationButtonView(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle Button",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Button",
                            message = "This is a widget that will define a button natively using the server " +
                                "driven information received through Beagle.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    createButton(
                        text = "Button",
                        flex = Flex(
                            margin = EdgeValue(
                                top = UnitValue(
                                    value = 15.0,
                                    type = UnitType.REAL
                                )
                            )
                        )
                    ),

                    createButton(
                        text = "Button with style",
                        style = "DesignSystem.Stylish.Button",
                        flex = Flex(
                            margin = EdgeValue(
                                top = UnitValue(
                                    value = 15.0,
                                    type = UnitType.REAL
                                )
                            )
                        )
                    ),

                    buttonWithAppearanceAndStyle(text = "Button with Appearance"),
                    buttonWithAppearanceAndStyle(
                        text = "Button with Appearance and style",
                        style = "DesignSystem.Stylish.ButtonAndAppearance"
                    )
                )
            )
        )
    }

    private fun buttonWithAppearanceAndStyle(text: String, style: String? = null): Widget {
        return createButton(
            text = text,
            style = style,
            flex = Flex(
                margin = EdgeValue(
                    left = UnitValue(value = 25.0, type = UnitType.REAL),
                    right = UnitValue(value = 25.0, type = UnitType.REAL),
                    top = UnitValue(value = 15.0, type = UnitType.REAL)
                )
            )
        ).applyAppearance(
            Appearance(
                backgroundColor = "0f4c81",
                cornerRadius = CornerRadius(radius = 16.0)
            )
        )
    }

    private fun createButton(
        text: String,
        style: String? = null,
        flex: Flex? = null
    ): Widget {
        val button = Button(
            text = text,
            style = style,
            action = Navigate(
                shouldPrefetch = true,
                type = NavigationType.ADD_VIEW,
                path = "/actionClick"
            )
        )

        if (flex != null) {
            button.applyFlex(flex)
        }

        return button
    }
}