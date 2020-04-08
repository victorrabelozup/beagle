/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_STYLE
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Text

object StackViewScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle StackView",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "StackView",
                        message = "Implements widgets on top of each other.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = Stack(
            children = listOf(
                Text("Text 1", SCREEN_TEXT_STYLE)
                    .applyFlex(
                        Flex(
                            margin = EdgeValue(
                                top = 5.unitReal()
                            )
                        )
                    ),
                Text("Text 2", SCREEN_TEXT_STYLE),
                Text("Text 3", SCREEN_TEXT_STYLE)
            )
        )
    )
}
