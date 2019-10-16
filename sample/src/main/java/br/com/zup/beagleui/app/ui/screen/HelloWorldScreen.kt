package br.com.zup.beagleui.app.ui.screen

import br.com.zup.beagleui.framework.core.Screen
import br.com.zup.beagleui.framework.layout.Container
import br.com.zup.beagleui.framework.ui.Text

class HelloWorldScreen : Screen {
    
    override fun build() = Container(
        content = Text("Hello World")
    )

}