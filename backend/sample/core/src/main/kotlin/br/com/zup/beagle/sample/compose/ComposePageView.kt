/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.compose

import br.com.zup.beagle.sample.constants.BLACK
import br.com.zup.beagle.sample.constants.LIGHT_GREY
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment

object ComposePageView : ComposeComponent() {
    override fun build() = PageView(
        pageIndicator = PageIndicator(
            selectedColor = BLACK,
            unselectedColor = LIGHT_GREY
        ),
        pages = (1..3).map(this::createText)
    )

    private fun createText(i: Int) = Text("Page $i", alignment = TextAlignment.CENTER)
        .applyFlex(
            Flex(
                alignSelf = Alignment.CENTER,
                grow = 1.0
            )
        )
}