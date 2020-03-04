package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleScreenBuilderService {
    fun createScreenBuilder(): ScreenBuilder = MyScreenBuilder("Hello World!")
}

private data class MyScreenBuilder(
    val title: String
) : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            "Beagle Screen",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "Screen",
                        message = "This component description and attribute details",
                        buttonText = "OK"
                    )
                )
            )
        ),
        content = Text(title)
    )
}