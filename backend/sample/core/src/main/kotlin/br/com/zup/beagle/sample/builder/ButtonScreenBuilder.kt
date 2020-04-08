/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BUTTON_STYLE
import br.com.zup.beagle.sample.constants.BUTTON_STYLE_APPEARANCE
import br.com.zup.beagle.sample.constants.CYAN_BLUE
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Button

object ButtonScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle Button",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "Button",
                        message = "This is a widget that will define a button natively using the server " +
                            "driven information received through Beagle.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = Container(
            children = listOf(
                createButton(
                    text = "Button",
                    flex = Flex(
                        margin = EdgeValue(
                            top = 15.unitReal()
                        )
                    )
                ),

                createButton(
                    text = "Button with style",
                    style = BUTTON_STYLE,
                    flex = Flex(
                        margin = EdgeValue(
                            top = 15.unitReal()
                        )
                    )
                ),

                buttonWithAppearanceAndStyle(text = "Button with Appearance"),
                buttonWithAppearanceAndStyle(
                    text = "Button with Appearance and style",
                    style = BUTTON_STYLE_APPEARANCE
                )
            )
        )
    )

    private fun buttonWithAppearanceAndStyle(text: String, style: String? = null) = createButton(
        text = text,
        style = style,
        flex = Flex(
            margin = EdgeValue(
                left = 25.unitReal(),
                right = 25.unitReal(),
                top = 15.unitReal()
            )
        )
    ).applyAppearance(
        Appearance(
            backgroundColor = CYAN_BLUE,
            cornerRadius = CornerRadius(radius = 16.0)
        )
    )

    private fun createButton(
        text: String,
        style: String? = null,
        flex: Flex? = null
    ): Widget {
        val button = Button(
            text = text,
            style = style,
            action = Navigate(
                shouldPrefetch = true,
                type = NavigationType.ADD_VIEW,
                path = SCREEN_ACTION_CLICK_ENDPOINT
            )
        )

        if (flex != null) {
            button.applyFlex(flex)
        }

        return button
    }
}