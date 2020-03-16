package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BUTTON_STYLE_ACCESSIBILITY
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
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
    override fun build(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Accessibility Screen",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Accessibility Screen",
                            message = "This method applies accessibility in a widget",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = Container(
                children = listOf(
                    textAccessibility(
                        text = "Accessibility Testing",
                        accessibilityLabel = "first text",
                        accessible = true
                    ),
                    textAccessibility(
                        text = "Accessibility disabled test",
                        accessibilityLabel = "second text",
                        accessible = false
                    ),
                    buttonAccessibility(
                        textButton = "First Text button",
                        accessibilityLabel = "This is a button as title",
                        accessible = true
                    ),
                    buttonAccessibility(
                        textButton = "Second Text button",
                        accessible = true
                    )
                )
            )
        )
    }

    private fun textAccessibility(
        text: String,
        accessibilityLabel: String,
        accessible: Boolean
    ): Widget {
        return Text(
            text = text
        ).applyAccessibility(
            accessibility = Accessibility(
                accessible = accessible,
                accessibilityLabel = accessibilityLabel
            )
        ).applyFlex(
            flex = Flex(
                alignItems = Alignment.CENTER,
                margin = EdgeValue(
                    top = 8.unitReal(),
                    bottom = 8.unitReal()
                )
            )
        )
    }

    private fun buttonAccessibility(
        textButton: String,
        accessibilityLabel: String? = null,
        accessible: Boolean
    ): Widget {
        return Button(
            text = textButton,
            style = BUTTON_STYLE_ACCESSIBILITY
        ).applyFlex(
            flex = Flex(
                size = Size(
                    height = 40.unitReal()
                ),
                alignItems = Alignment.CENTER,
                margin = EdgeValue(
                    top = 8.unitReal(),
                    bottom = 8.unitReal()
                )
            )
        ).applyAccessibility(
            accessibility = Accessibility(
                accessible = accessible,
                accessibilityLabel = accessibilityLabel
            )
        )
    }
}