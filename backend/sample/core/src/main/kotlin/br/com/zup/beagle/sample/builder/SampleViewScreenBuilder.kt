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
import br.com.zup.beagle.sample.constants.PATH_SAMPLE_VIEW_ENDPOINT
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Button

object SampleViewScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Sample Bar",
            style = "Style.Default",
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "First",
                    image = "delete",
                    action = Navigate(
                        type = NavigationType.POP_VIEW,
                        path = PATH_SAMPLE_VIEW_ENDPOINT
                    )
                ),
                NavigationBarItem(
                    text = "Second",
                    image = "question",
                    action = Navigate(
                        type = NavigationType.POP_VIEW
                    )
                )
            )
        ),
        child = Button("").applyFlex(Flex(justifyContent = JustifyContent.CENTER))
    )
}