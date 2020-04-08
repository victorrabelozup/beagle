/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.compose

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.LIGHT_GREY
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text

object ComposeScrollView : ComposeComponent() {
    override fun build() = ScrollView(
        scrollBarEnabled = false,
        scrollDirection = ScrollAxis.HORIZONTAL,
        children = listOf(
            createText().applyAppearance(Appearance(backgroundColor = LIGHT_GREY))
                .applyFlex(
                    Flex(
                        margin = EdgeValue(
                            left = 30.unitReal()
                        )
                    )
                )
        ) + List(20) { createText() }
    )

    private fun createText() = Text("Text")
}
