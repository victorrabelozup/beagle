package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleNetworkImageService {
    fun creationNetworkImage(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle NetworkImage",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "NetworkImage",
                            message = "It is a widget that implements an image with a URL.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = ScrollView(
                scrollDirection = ScrollAxis.VERTICAL,
                children = listOf(
                    buildImage(title = "NetworkImage"),
                    buildImage(
                        title = "NetworkImage with ImageContentMode.CENTER",
                        mode = ImageContentMode.CENTER
                    ),
                    buildImage(
                        title = "NetworkImage with ImageContentMode.CENTER_CROP",
                        mode = ImageContentMode.CENTER_CROP
                    ),
                    buildImage(
                        title = "NetworkImage with ImageContentMode.FIT_CENTER",
                        mode = ImageContentMode.FIT_CENTER
                    ),
                    buildImage(
                        title = "NetworkImage with ImageContentMode.FIT_XY",
                        mode = ImageContentMode.FIT_XY
                    )

                )
            )
        )
    }

    private fun buildImage(title: String, mode: ImageContentMode? = null): Container {
        return Container(
            children = listOf(
                buildText(
                    text = title
                ),
                NetworkImage(
                    path = "https://www.guiaviagensbrasil.com/imagens/Imagem%20do%20mar%20calma" +
                        "%20e%20belo%20da%20Praia%20da%20Engenhoca-Itacar%C3%A9-Bahia-BA.jpg",
                    contentMode = mode
                ).applyFlex(
                    flex = Flex(
                        size = Size(
                            width = UnitValue(150.0, UnitType.REAL),
                            height = UnitValue(130.0, UnitType.REAL)
                        ),
                        alignSelf = Alignment.CENTER
                    )
                )
            )
        )
    }

    private fun buildText(text: String) = Text(
        text = text,
        style = "DesignSystem.Text.NetworkImage"
    ).applyFlex(
        flex = Flex(
            alignSelf = Alignment.CENTER,
            margin = EdgeValue(
                top = UnitValue(8.0, UnitType.REAL)
            )
        )
    )

}
