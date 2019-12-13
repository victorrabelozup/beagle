package br.com.zup.beagle.sample.ui.screen

import br.com.zup.beagle.sample.widget.CustomWidget
import br.com.zup.beagle.widget.core.Screen
import br.com.zup.beagle.widget.layout.Container

class HelloWorldScreen : Screen {
    
    override fun build() = Container(
        content = CustomWidget()
    )
}