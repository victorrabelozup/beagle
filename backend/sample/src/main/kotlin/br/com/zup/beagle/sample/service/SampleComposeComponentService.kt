package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.compose.CustomComposeComponent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import org.springframework.stereotype.Service

@Service
class SampleComposeComponentService {
    fun creationComposeComponentView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Compose Component",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Compose Component",
                            message = "Creates components to call in different places.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    CustomComposeComponent()
                )
            )
        )
    }
}