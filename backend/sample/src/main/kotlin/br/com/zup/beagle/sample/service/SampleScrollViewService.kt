package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleScrollViewService {
    fun creationScrollView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle ScrollView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "ScrollView",
                            message = "This component is a specialized container that will display its " +
                                "components in a Scroll like view.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    getVerticalScrollView(),
                    getHorizontalScrollView()
                )
            )
        )
    }

    private fun getVerticalScrollView(): Widget {
        return Container(
            children = listOf(
                Text("Vertical ScrollView"),
                ScrollView(
                    children = listOf(
                        Text("Hello 1", "DesignSystem.Text.Action.Click"),
                        Text("Hello 2", "DesignSystem.Text.Action.Click"),
                        Text("Hello 3", "DesignSystem.Text.Action.Click"),
                        Text("Hello 4", "DesignSystem.Text.Action.Click"),
                        Text("Hello 5", "DesignSystem.Text.Action.Click")
                    ),
                    scrollDirection = ScrollAxis.VERTICAL
                )
            )
        ).applyFlex(
            flex = Flex(
                size = Size(
                    height = UnitValue(130.0, UnitType.REAL),
                    width = UnitValue(100.0, UnitType.PERCENT)
                )
            )
        )
    }

    private fun getHorizontalScrollView(): Container {
        return Container(
            children = listOf(
                Text("Horizontal ScrollView with scrollBars"),
                ScrollView(
                    children = listOf(
                        Text("Hello 1", "DesignSystem.Text.Action.Click"),
                        Text("Hello 2", "DesignSystem.Text.Action.Click"),
                        Text("Hello 3", "DesignSystem.Text.Action.Click"),
                        Text("Hello 4", "DesignSystem.Text.Action.Click"),
                        Text("Hello 5", "DesignSystem.Text.Action.Click")

                    ),
                    scrollDirection = ScrollAxis.HORIZONTAL
                )
            )
        )
    }
}
