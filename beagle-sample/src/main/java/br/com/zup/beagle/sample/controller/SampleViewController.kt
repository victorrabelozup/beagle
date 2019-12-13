package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.ui.screen.HelloWorldScreen
import br.com.zup.beagle.widget.core.ScreenBuilder
import br.com.zup.beagle.widget.core.Widget
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class SampleViewController {

    @RequestMapping("/sample")
    fun getSampleView(): Widget {
        return ScreenBuilder().build(HelloWorldScreen())
    }
}
