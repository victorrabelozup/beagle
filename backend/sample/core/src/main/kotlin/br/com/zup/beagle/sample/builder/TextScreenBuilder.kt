/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_STYLE
import br.com.zup.beagle.sample.constants.STEEL_BLUE
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text

object TextScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle Text",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "Text",
                        message = "This widget will define a text view natively using the server driven " +
                            "information received through Beagle.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = Container(
            children = listOf(
                beagleText(text = "hello world without style"),
                beagleText(text = "hello world with style", style = SCREEN_TEXT_STYLE),
                beagleText(text = "hello world with Appearance", appearanceColor = STEEL_BLUE),
                beagleText(
                    text = "hello world with style and Appearance",
                    style = SCREEN_TEXT_STYLE,
                    appearanceColor = STEEL_BLUE
                )
            )
        )
    )

    private fun beagleText(
        text: String,
        style: String? = null,
        appearanceColor: String? = null
    ) =
        Text(text = text, style = style)
            .applyFlex(
                flex = Flex(
                    margin = EdgeValue(
                        top = 16.unitReal(),
                        start = 16.unitReal(),
                        end = 16.unitReal()
                    )
                )
            ).applyAppearance(
                appearance = Appearance(
                    backgroundColor = appearanceColor
                )
            )
}
