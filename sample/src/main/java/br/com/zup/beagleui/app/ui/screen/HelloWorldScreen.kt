package br.com.zup.beagleui.app.ui.screen

import br.com.zup.beagleui.app.widget.CustomWidget
import br.com.zup.beagleui.framework.widget.core.Screen
import br.com.zup.beagleui.framework.widget.layout.Container

class HelloWorldScreen : Screen {
    
    override fun build() = Container(
        content = CustomWidget()
    )
}