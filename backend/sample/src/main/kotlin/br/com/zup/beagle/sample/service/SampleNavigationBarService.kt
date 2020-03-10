package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BUTTON_STYLE_TITLE
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.NAVIGATION_BAR_STYLE
import br.com.zup.beagle.sample.constants.NAVIGATION_BAR_STYLE_DEFAULT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.sample.constants.TEXT_FONT_MAX
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleNavigationBarService {
    fun createNavigationBarView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Beagle NavigationBar",
                style = NAVIGATION_BAR_STYLE_DEFAULT,
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
            child = Container(
                children = listOf(
                    createMenu(text = "NavigationBar", path = REPRESENTATION_NAVIGATION_BAR_ENDPOINT),
                    createMenu(text = "NavigationBar with Style", path = REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT),
                    createMenu(
                        text = "NavigationBar with Item(Text)",
                        path = REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT
                    ),
                    createMenu(
                        text = "NavigationBar with Item(Image)",
                        path = REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT
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
            styleNavigation = NAVIGATION_BAR_STYLE,
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
                        path = SCREEN_ACTION_CLICK_ENDPOINT
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
                    image = LOGO_BEAGLE,
                    action = Navigate(
                        type = NavigationType.ADD_VIEW,
                        path = SCREEN_ACTION_CLICK_ENDPOINT
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
            child = Container(
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
            style = TEXT_FONT_MAX
        )

    }

    private fun createMenu(text: String, path: String): Widget {
        return Button(
            text = text,
            action = Navigate(
                type = NavigationType.ADD_VIEW,
                path = path
            ),
            style = BUTTON_STYLE_TITLE
        ).applyFlex(
            flex = Flex(
                margin = EdgeValue(
                    top = 8.unitReal()
                )
            )
        )
    }
}
