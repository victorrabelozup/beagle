package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleNavigationBarService {
    fun creationNavigationBarView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Beagle NavigationBar",
                style = "DesignSystem.Navigationbar.Style.Default",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "NavigationBar",
                            message = "This component that allows to place titles and button action.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    createMenu(text = "NavigationBar", path = "/navigationbar"),
                    createMenu(text = "NavigationBar with Style", path = "/navigationbar/style"),
                    createMenu(
                        text = "NavigationBar with Item(Text)",
                        path = "/navigationbar/item/text"
                    ),
                    createMenu(
                        text = "NavigationBar with Item(Image)",
                        path = "/navigationbar/item/image"
                    )
                )
            )
        )
    }


    fun navigationBar(): Screen {
        return createNavigationBar(
            titleNavigation = "NavigationBar",
            text = "NavigationBar"
        )
    }


    fun navigationBarStyle(): Screen {
        return createNavigationBar(
            titleNavigation = "NavigationBar",
            styleNavigation = "DesignSystem.Navigationbar.Style.Green",
            text = "NavigationBar with Style"
        )
    }


    fun navigationBarWithTextAsItemt(): Screen {
        return createNavigationBar(
            titleNavigation = "NavigationBar",
            text = "NavigationBar with Item(Text)",
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "Entrar",
                    action = Navigate(
                        type = NavigationType.ADD_VIEW,
                        path = "/actionClick"
                    )
                )
            )
        )
    }


    fun navigationBarWithImageAsItem(): Screen {
        return createNavigationBar(
            titleNavigation = "NavigationBar",
            text = "NavigationBar with Item(Image)",
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "imageBeagle",
                    action = Navigate(
                        type = NavigationType.ADD_VIEW,
                        path = "/actionClick"
                    )
                )
            )
        )
    }

    private fun createNavigationBar(
        titleNavigation: String,
        styleNavigation: String? = null,
        text: String,
        navigationBarItems: List<NavigationBarItem>? = null
    ): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = titleNavigation,
                style = styleNavigation,
                showBackButton = true,
                navigationBarItems = navigationBarItems
            ),
            content = Container(
                children = listOf(
                    createBeagleText(text)
                )
            ).applyFlex(
                flex = Flex(
                    alignItems = Alignment.CENTER
                )
            )
        )
    }

    private fun createBeagleText(text: String): Text {
        return Text(
            text = text,
            style = "DesignSystem.Text.Action.Click"
        )

    }

    private fun createMenu(text: String, path: String): Widget {
        return Button(
            text = text,
            action = Navigate(
                type = NavigationType.ADD_VIEW,
                path = path
            ),
            style = "DesignSystem.Button.Style"
        ).applyFlex(
            flex = Flex(
                margin = EdgeValue(
                    top = UnitValue(8.0, UnitType.REAL)
                )
            )
        )
    }
}
