package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class AccessibilityController {

    @RequestMapping("/accessibility")
    fun getAccessibilityView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Teste de Acessibilidade",
                showBackButton = true
            ),
            content = Container(
                children = listOf(
                    Text("Texto numero um")
                        .applyAccessibility(
                            Accessibility(
                                accessibilityLabel = "Primeiro texto"
                            )
                        ),
                    Button(
                        text = "Botao de texto",
                        style = "DesignSystem.Button.White"
                    )
                        .applyAccessibility(
                            Accessibility(
                                accessibilityLabel = "Isso eh um botao como titulo"
                            )
                        )
                        .applyFlex(
                            flex = Flex(
                                size = Size(
                                    height = UnitValue(40.0, UnitType.REAL)
                                )
                            )
                        ),
                    Button(
                        text = "outro botao de texto",
                        style = "DesignSystem.Button.White"
                    )
                        .applyAccessibility(
                            Accessibility(
                                accessible = false
                            )
                        )
                )
            )
        )
    }
}