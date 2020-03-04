package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Button
import org.springframework.stereotype.Service

@Service
class SampleComponentsService {
    fun getCreationSampleComponentsView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Choose a Component",
                showBackButton = true
            ),
            content = ScrollView(
                scrollDirection = ScrollAxis.VERTICAL,
                children = listOf(
                    createMenu("Button", "/sampleButton"),
                    createMenu("Text", "/sampleText"),
                    createMenu("Image", "/sampleImage"),
                    createMenu("NetworkImage", "/sampleNetworkImage"),
                    createMenu("TabView", "/sampleTabView"),
                    createMenu("ListView", "/listview"),
                    createMenu("ScrollView", "/scrollview"),
                    createMenu("PageView", "/pageView"),
                    createMenu("Action", "/action"),
                    createMenu("ScreenBuilder", "/screenbuilder"),
                    createMenu("Form", "/sample/form"),
                    createMenu("LazyComponent", "/lazycomponent"),
                    createMenu("NavigationBar", "/navigation/bar"),
                    createMenu("NavigationType", "/navigationbar/step1"),
                    createMenu("Stack View", "/sampleStackView"),
                    createMenu("Accessibility Screen", "/sampleAccessibilityScreen"),
                    createMenu("Compose Component", "/sampleComposeComponent"),
                    createMenu("Touchable", "/sampleTouchable")
                )
            )
        )
    }

    private fun createMenu(text: String, path: String): Widget {
        return Button(
            text = text,
            action = Navigate(
                type = NavigationType.ADD_VIEW,
                path = path
            ),
            style = "DesignSystem.Button.Style"
        ).applyFlex(
            flex = Flex(
                margin = EdgeValue(
                    top = UnitValue(8.0, UnitType.REAL)
                )
            )
        )
    }
}
