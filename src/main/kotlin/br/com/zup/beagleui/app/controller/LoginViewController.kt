package br.com.zup.beagleui.app.controller

import br.com.zup.beagleui.app.view.LoginView
import br.com.zup.beagleui.framework.core.ScreenBuilder
import br.com.zup.beagleui.framework.core.Widget
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping

@RestController
class LoginViewController {

    @RequestMapping("/loginview")
    fun index(): Widget {
        return ScreenBuilder().build(LoginView())
    }

}