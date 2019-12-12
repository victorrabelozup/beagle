package br.com.zup.beagle.app.controller

import br.com.zup.beagleui.app.ui.screen.HelloWorldScreen
import br.com.zup.beagleui.framework.widget.core.ScreenBuilder
import br.com.zup.beagleui.framework.widget.core.Widget
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class SampleViewController {

    @RequestMapping("/sample")
    fun getSampleView(): Widget {
        return ScreenBuilder().build(HelloWorldScreen())
    }
}
