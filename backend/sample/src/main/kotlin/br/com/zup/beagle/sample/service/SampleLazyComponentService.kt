package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.lazy.LazyComponent
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleLazyComponentService {
    fun creationLazyComponent(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle LazyComponent",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Lazy Component",
                            message = "A widget that implements loading.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    LazyComponent(
                        path = "http://www.mocky.io/v2/5e4e91c02f00001f2016a8f2",
                        initialState = Text("Loading...").applyFlex(
                            flex = Flex(
                                justifyContent = JustifyContent.CENTER,
                                alignSelf = Alignment.CENTER
                            )
                        )
                    )
                )
            )
        )
    }
}
