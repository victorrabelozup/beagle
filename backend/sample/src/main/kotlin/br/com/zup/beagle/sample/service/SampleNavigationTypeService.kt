package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Button
import org.springframework.stereotype.Service

@Service
class SampleNavigationTypeService {

    private val buttonPopView = createButton(
        text = "POP_VIEW",
        navigationType = NavigationType.POP_VIEW,
        backgroundColor = "0f4c81"
    )

    private val buttonAddViewStep1 = createButton(
        text = "ADD_VIEW (Step 1)",
        path = "navigationbar/step1",
        navigationType = NavigationType.ADD_VIEW,
        backgroundColor = "ed6663"
    )

    fun creationNavigationTypeView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Step 1",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Navigation Type",
                            message = "Decide the type of navigation.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    buttonPopView,
                    createButton(
                        text = "ADD_VIEW (Step 2)",
                        path = "/navigationbar/step2",
                        navigationType = NavigationType.ADD_VIEW,
                        backgroundColor = "ed6663"
                    )

                )
            )
        )
    }


    fun step2(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Step 2",
                showBackButton = true
            ),
            content = Container(
                children = listOf(
                    buttonPopView,
                    createButton(
                        text = "ADD_VIEW (Step 3)",
                        path = "/navigationbar/step3",
                        navigationType = NavigationType.ADD_VIEW,
                        backgroundColor = "ed6663"
                    ),
                    createButton(
                        text = "PRESENT_VIEW",
                        path = "/present/view",
                        navigationType = NavigationType.PRESENT_VIEW,
                        backgroundColor = "ffa372"
                    )

                )
            )
        )
    }


    fun presentView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Present",
                showBackButton = true
            ),
            content = Container(
                children = listOf(
                    buttonPopView,
                    buttonAddViewStep1,
                    createButton(
                        text = "FINISH_VIEW",
                        navigationType = NavigationType.FINISH_VIEW,
                        backgroundColor = "2a7886"
                    )

                )
            )
        )
    }


    fun step3(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                title = "Step 3",
                showBackButton = true
            ),
            content = Container(
                children = listOf(
                    buttonPopView,
                    createButton(
                        text = "SWAP_VIEW (Step 1)",
                        path = "/navigationbar/step1",
                        navigationType = NavigationType.SWAP_VIEW,
                        backgroundColor = "b7472a"
                    ),
                    createButton(
                        text = "POP_TO_VIEW (Step 1)",
                        path = "/navigationbar/step1",
                        navigationType = NavigationType.POP_TO_VIEW,
                        backgroundColor = "c81912"
                    ),
                    buttonAddViewStep1

                )
            )
        )
    }

    private fun createButton(
        text: String,
        path: String? = null,
        navigationType: NavigationType,
        backgroundColor: String
    ): Widget {
        return Button(
            text = text,
            style = "DesignSystem.Stylish.ButtonAndAppearance",
            action = Navigate(
                type = navigationType,
                path = path
            )
        ).applyAppearance(
            Appearance(
                backgroundColor = backgroundColor,
                cornerRadius = CornerRadius(radius = 10.0)
            )
        ).applyFlex(
            flex = Flex(
                margin = EdgeValue(
                    left = UnitValue(value = 30.0, type = UnitType.REAL),
                    right = UnitValue(value = 30.0, type = UnitType.REAL),
                    top = UnitValue(value = 15.0, type = UnitType.REAL)
                )
            )
        )

    }
}
