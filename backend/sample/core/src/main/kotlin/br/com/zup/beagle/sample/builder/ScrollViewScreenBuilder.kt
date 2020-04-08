/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.ext.unitPercent
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.TEXT_FONT_MAX
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text

object ScrollViewScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle ScrollView",
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
        child = ScrollView(
            scrollDirection = ScrollAxis.VERTICAL,
            children = listOf(
                getVerticalScrollView(),
                getHorizontalScrollView()
            )
        )
    )

    private fun getVerticalScrollView() = Container(
        children = listOf(
            Text("Vertical ScrollView"),
            ScrollView(
                children = listOf(
                    createText("Hello 1"),
                    createText("Hello 2"),
                    createText("Hello 3"),
                    createText("Hello 4"),
                    createText("Hello 5")
                ),
                scrollDirection = ScrollAxis.VERTICAL
            )
        )
    ).applyFlex(
        flex = Flex(
            size = Size(
                height = 130.unitReal(),
                width = 100.unitPercent()
            )
        )
    )

    private fun getHorizontalScrollView() = Container(
        children = listOf(
            Text("Horizontal ScrollView with scrollBars"),
            ScrollView(
                children = listOf(
                    createText("Hello 1"),
                    createText("Hello 2"),
                    createText("Hello 3"),
                    createText("Hello 4"),
                    createText("Hello 5")

                ),
                scrollDirection = ScrollAxis.HORIZONTAL
            )
        )
    )

    private fun createText(text: String) = Text(text, TEXT_FONT_MAX)
}
