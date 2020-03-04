package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.navigation.Touchable
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleTouchableService {
    fun creationTouchableView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Touchable",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Touchable",
                            message = "Applies cl" +
                                "ick action on widgets that have no action.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    touchableCustom(title = "Text with Touchable", item = Text("Click Aqui!")),
                    touchableCustom(title = "Image with Touchable", item = Image("imageBeagle")),
                    networkImageTouchable()
                )
            )
        )
    }

    private fun touchableCustom(item: Widget, title: String): ServerDrivenComponent {
        return Container(
            children = listOf(
                buildTitle(
                    text = title
                ),
                Touchable(
                    action = Navigate(
                        path = "/actionClick",
                        type = NavigationType.ADD_VIEW
                    ), child = item.applyFlex(
                        flex = Flex(
                            alignSelf = Alignment.CENTER,
                            margin = EdgeValue(
                                top = UnitValue(8.0, UnitType.REAL),
                                bottom = UnitValue(8.0, UnitType.REAL)
                            )
                        )
                    )
                )
            )
        )
    }

    private fun buildTitle(text: String) = Text(
        text = text,
        style = "DesignSystem.Text.helloWord"
    ).applyFlex(
        flex = Flex(
            alignSelf = Alignment.CENTER,
            margin = EdgeValue(
                top = UnitValue(8.0, UnitType.REAL)
            )
        )
    )

    private fun networkImageTouchable(): ServerDrivenComponent {
        return Container(
            children = listOf(
                buildTitle(
                    "NetworkImage with Touchable"
                ),
                Touchable(
                    child = NetworkImage(
                        path = "https://www.guiaviagensbrasil.com/imagens/Imagem%20do%20mar%20calma%20e%20belo%20da" +
                            "%20Praia%20da%20Engenhoca-Itacar%C3%A9-Bahia-BA.jpg"
                    ).applyFlex(
                        flex = Flex(
                            size = Size(
                                width = UnitValue(150.0, UnitType.REAL),
                                height = UnitValue(130.0, UnitType.REAL)
                            ),
                            alignSelf = Alignment.CENTER
                        )
                    ),
                    action = Navigate(
                        path = "/actionClick",
                        type = NavigationType.ADD_VIEW
                    )
                )
            )
        )

    }
}
