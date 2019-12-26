package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class SampleViewController {

    @RequestMapping("/sample")
    fun getSampleView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Sample Bar",
                showBackButton = true
            ),
            content = FlexWidget(
                flex = Flex(justifyContent = JustifyContent.CENTER),
                children = listOf(
                    Button("")
                )
            )
        )
    }
}
