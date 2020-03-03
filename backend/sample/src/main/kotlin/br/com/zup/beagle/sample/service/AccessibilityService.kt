package br.com.zup.beagle.sample.service

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class AccessibilityService {
    fun createAccessibilityView() = AccessibilityScreenBuilder.build()
}

private object AccessibilityScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
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
                createButton("Botao de texto")
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
                createButton("outro botao de texto")
                    .applyAccessibility(
                        Accessibility(
                            accessible = false
                        )
                    )
            )
        )
    )

    private fun createButton(text: String) = Button(text = text, style = "DesignSystem.Button.White")
}