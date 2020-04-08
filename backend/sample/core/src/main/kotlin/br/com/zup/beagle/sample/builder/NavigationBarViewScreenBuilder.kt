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
import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BUTTON_STYLE_TITLE
import br.com.zup.beagle.sample.constants.NAVIGATION_BAR_STYLE_DEFAULT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Button

object NavigationBarViewScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            backButtonAccessibility = Accessibility(
                accessibilityLabel = "Voltar"
            ),
            title = "Beagle NavigationBar",
            style = NAVIGATION_BAR_STYLE_DEFAULT,
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "Ajuda",
                    accessibility = Accessibility(accessibilityLabel = "Content Description"),
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "NavigationBar",
                        message = "This component that allows to place titles and button action.",
                        buttonText = "OK"
                    )
                ).setId("nbiInformation")
            )
        ),
        child = Container(
            children = listOf(
                createMenu("NavigationBar", REPRESENTATION_NAVIGATION_BAR_ENDPOINT),
                createMenu("NavigationBar with Style", REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT),
                createMenu("NavigationBar with Item(Text)", REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT),
                createMenu("NavigationBar with Item(Image)", REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT)
            )
        )
    )

    private fun createMenu(text: String, path: String) = Button(
        text = text,
        action = Navigate(
            type = NavigationType.ADD_VIEW,
            path = path
        ),
        style = BUTTON_STYLE_TITLE
    ).applyFlex(
        flex = Flex(
            margin = EdgeValue(
                top = 8.unitReal()
            )
        )
    )
}
