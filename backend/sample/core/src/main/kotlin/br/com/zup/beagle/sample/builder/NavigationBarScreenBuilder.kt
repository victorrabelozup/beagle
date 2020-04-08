/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.sample.constants.TEXT_FONT_MAX
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text

class NavigationBarScreenBuilder(
    private val titleNavigation: String,
    private val styleNavigation: String? = null,
    private val text: String,
    private val navigationBarItems: List<NavigationBarItem>? = null
) : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = this.titleNavigation,
            style = this.styleNavigation,
            showBackButton = true,
            navigationBarItems = this.navigationBarItems
        ),
        child = this.createBeagleText(this.text)
    )

    private fun createBeagleText(text: String) = Text(text = text, style = TEXT_FONT_MAX)
        .applyFlex(
            flex = Flex(
                alignItems = Alignment.CENTER
            )
        )
}
