/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.sample.compose

import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.core.PositionType
import br.com.zup.beagle.core.Style
import br.com.zup.beagle.ext.applyStyle
import br.com.zup.beagle.ext.unitPercent
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.LIGHT_GREY
import br.com.zup.beagle.sample.constants.WHITE
import br.com.zup.beagle.widget.action.SetContext
import br.com.zup.beagle.widget.context.ContextData
import br.com.zup.beagle.widget.context.expressionOf
import br.com.zup.beagle.widget.core.*
import br.com.zup.beagle.widget.layout.ComposeComponent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ImagePath
import br.com.zup.beagle.widget.ui.Text

object ComposeBeagleViewCenter: ComposeComponent {
    override fun build() = Container(
        children = listOf(
            PageView(
                children = listOf(
                    page1,
                    page2,
                    page3
                ),
                onPageChange = listOf(SetContext("context", "@{onPageChange}")),
                currentPage = expressionOf("@{context}")
            ),
            PageIndicator(
                numberOfPages = 3,
                selectedColor = WHITE,
                unselectedColor = LIGHT_GREY,
                currentPage = expressionOf("@{context}")
            )
        ),
        context = ContextData("context", 0)
    ).applyStyle(
        Style(
            size = Size(width = 80.unitPercent(), height = 200.unitReal()),
            flex = Flex(alignSelf = AlignSelf.CENTER),
            cornerRadius = CornerRadius(radius = 10.0),
            backgroundColor = "#061a24"
        )
    )

    private val page1 = createPage()
    private val page2 = createPage()
    private val page3 = createPage()

    private fun createPage() = Container(
        listOf(
            Image(
                ImagePath.Local.justMobile("imageBeagle")
            ).applyStyle(
                Style(
                    size = Size(width = 100.unitReal(), height = 100.unitReal()),
                    flex = Flex(
                        alignSelf = AlignSelf.CENTER
                    ),
                    cornerRadius = CornerRadius(radius = 8.0)
                )
            ),

            Text(
                "This is a server driven component!",
                styleId = "DesignSystem.Text.White",
                alignment = TextAlignment.CENTER
            ).applyStyle(
                Style(
                    flex = Flex(alignSelf = AlignSelf.CENTER)
                )
            )
        )
    ).applyStyle(
        Style(
            flex = Flex(justifyContent = JustifyContent.CENTER, grow = 1.0)
        )
    )
}