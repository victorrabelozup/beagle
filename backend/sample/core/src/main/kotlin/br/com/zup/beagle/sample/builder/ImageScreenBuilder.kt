/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.TITLE_SCREEN
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text

object ImageScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle Image",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "Image",
                        message = "This widget will define a image view natively using the server driven " +
                            "information received through Beagle.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = ScrollView(
            scrollDirection = ScrollAxis.VERTICAL,
            children = listOf(createText("Image"), Image(LOGO_BEAGLE)) +
                ImageContentMode.values().flatMap(this::createImageWithModeAndText)
        )
    )

    private fun createText(text: String) = Text(text = text, style = TITLE_SCREEN)

    private fun createImageWithModeAndText(mode: ImageContentMode) =
        listOf(createText("Image with contentMode = $mode"), Image(LOGO_BEAGLE, mode))
}
