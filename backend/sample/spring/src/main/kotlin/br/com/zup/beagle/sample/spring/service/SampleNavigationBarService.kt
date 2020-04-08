/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.spring.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.sample.builder.NavigationBarScreenBuilder
import br.com.zup.beagle.sample.builder.NavigationBarViewScreenBuilder
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.NAVIGATION_BAR_STYLE
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.widget.layout.NavigationBarItem
import org.springframework.stereotype.Service

@Service
class SampleNavigationBarService {
    fun createNavigationBarView() = NavigationBarViewScreenBuilder

    fun navigationBar() = NavigationBarScreenBuilder(
        titleNavigation = "NavigationBar",
        text = "NavigationBar"
    )

    fun navigationBarStyle() = NavigationBarScreenBuilder(
        titleNavigation = "NavigationBar",
        styleNavigation = NAVIGATION_BAR_STYLE,
        text = "NavigationBar with Style"
    )

    fun navigationBarWithTextAsItems() = NavigationBarScreenBuilder(
        titleNavigation = "NavigationBar",
        text = "NavigationBar with Item(Text)",
        navigationBarItems = listOf(
            NavigationBarItem(
                text = "Entrar",
                action = Navigate(
                    type = NavigationType.ADD_VIEW,
                    path = SCREEN_ACTION_CLICK_ENDPOINT
                )
            )
        )
    )

    fun navigationBarWithImageAsItem() = NavigationBarScreenBuilder(
        titleNavigation = "NavigationBar",
        text = "NavigationBar with Item(Image)",
        navigationBarItems = listOf(
            NavigationBarItem(
                text = "",
                image = LOGO_BEAGLE,
                action = Navigate(
                    type = NavigationType.ADD_VIEW,
                    path = SCREEN_ACTION_CLICK_ENDPOINT
                )
            )
        )
    )
}
