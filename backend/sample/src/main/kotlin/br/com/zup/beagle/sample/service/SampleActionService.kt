package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.navigation.Touchable
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleActionService {
    fun creationAction(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Action",
                showBackButton = true,
                style = "DesignSystem.Navigationbar.Style.Default",
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Action",
                            message = "This class handles transition actions between screens in the application. ",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    getShowNativeDialogAction(),
                    getNavigateWithPath(),
                    getNavigateWithScreen(),
                    getNavigateWithPathScreen(),
                    getNavigateWithPrefetch(),
                    getNavigateWithDeepLink()
                )
            )
        )
    }

    private fun getShowNativeDialogAction(): Container {
        return Container(
            children = listOf(
                Text("Show Native Dialog"),
                Touchable(
                    action = ShowNativeDialog(
                        title = "Some",
                        message = "Action",
                        buttonText = "OK"
                    ),
                    child = Text("Click me!").applyFlex(
                        flex = Flex(
                            alignSelf = Alignment.CENTER
                        )
                    )
                )
            )
        )
    }

    private fun getNavigateWithPath(): Container {
        return Container(
            children = listOf(
                Text("Navigate with path"),
                Button(
                    action = Navigate(
                        path = "/actionClick",
                        type = NavigationType.ADD_VIEW
                    ),
                    text = "Click me!"
                )
            )
        )
    }

    private fun getNavigateWithScreen(): Container {
        return Container(
            children = listOf(
                Text("Navigate with screen"),
                Button(
                    action = Navigate(
                        screen = Screen(
                            navigationBar = NavigationBar(
                                "Navigate with screen",
                                showBackButton = true
                            ),
                            content = Text("Hello Screen from Navigate")
                        ),
                        type = NavigationType.ADD_VIEW
                    ),
                    text = "Click me!"
                )
            )
        )
    }

    private fun getNavigateWithPathScreen(): Container {
        return Container(
            children = listOf(
                Text("Navigate with path and screen"),
                Button(
                    action = Navigate(
                        path = "guhdthjfgjjbk",
                        screen = Screen(
                            navigationBar = NavigationBar(
                                "Navigate with path and screen",
                                showBackButton = true
                            ),
                            content = Text("Hello Screen from Navigate")
                        ),
                        type = NavigationType.ADD_VIEW
                    ),
                    text = "Click me!"
                )
            )
        )
    }

    private fun getNavigateWithPrefetch(): Container {
        return Container(
            children = listOf(
                Text("Navigate with prefetch"),
                Button(
                    action = Navigate(
                        path = "/actionClick",
                        shouldPrefetch = true,
                        type = NavigationType.ADD_VIEW
                    ),
                    text = "Click me!"
                )
            )
        )
    }

    private fun getNavigateWithDeepLink(): Container {
        return Container(
            children = listOf(
                Text("Navigate with data"),
                Button(
                    action = Navigate(
                        path = "screenDeepLink",
                        data = mapOf("data" to "for", "native" to "view"),
                        type = NavigationType.OPEN_DEEP_LINK
                    ),
                    text = "Click me!"
                )
            )
        )
    }


    fun getNavigateExample(): Screen {
        return Screen(
            content = Text("Hello")
        )
    }
}
