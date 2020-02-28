package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class SampleScreenBuilderController {

    @RequestMapping("/screenbuilder")
    fun getScreenBuilder(): ScreenBuilder {
        return MyScreenBuilder("Hello World!")
    }
}

data class MyScreenBuilder(
    val title: String
) : ScreenBuilder {
    override fun build(): Screen {
        return Screen(
            content = Text(title)
        )
    }
}