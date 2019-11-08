package br.com.zup.beagleui.app.controller

import br.com.zup.beagleui.app.ui.screen.HelloWorldScreen
import br.com.zup.beagleui.framework.widget.core.ScreenBuilder
import br.com.zup.beagleui.framework.widget.core.Widget
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping

@RestController
class SampleViewController {

    @RequestMapping("/sample")
    fun getSampleView(): Widget {
        return ScreenBuilder().build(HelloWorldScreen())
    }
}