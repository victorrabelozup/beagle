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
import br.com.zup.beagle.core.Style
import br.com.zup.beagle.ext.applyFlex
import br.com.zup.beagle.ext.applyStyle
import br.com.zup.beagle.ext.unitPercent
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.WHITE
import br.com.zup.beagle.widget.action.Navigate
import br.com.zup.beagle.widget.core.*
import br.com.zup.beagle.widget.layout.ComposeComponent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ImagePath
import br.com.zup.beagle.widget.ui.Text

object ComposeBeagleViewBottom: ComposeComponent {
    override fun build() = Container(
        children = listOf(
            Container(
                listOf(
                    Text(
                        "Beagle",
                        styleId = "DesignSystem.Text.White"
                    ).applyFlex(Flex(alignSelf = AlignSelf.CENTER)),

                    Image(
                        ImagePath.Local.justMobile("imageBeagle")
                    ).applyStyle(
                        Style(
                            size = Size(width = 50.unitReal(), height = 50.unitReal()),
                            flex = Flex(alignSelf = AlignSelf.CENTER),
                            cornerRadius = CornerRadius(radius = 8.0)
                        )
                    )
                )
            ).applyStyle(
                Style(
                    size = Size(width = 50.unitPercent(), height = 100.unitPercent()),
                    flex = Flex(alignSelf = AlignSelf.CENTER),
                    padding = EdgeValue(all = 15.unitReal())
                )
            ),

            Button(
                text = "Documentation",
                styleId = "DesignSystem.Button.Blue",
                onPress = listOf(Navigate.OpenExternalURL(url = "https://docs.usebeagle.io/"))
            ).applyStyle(
                Style(
                    backgroundColor = WHITE,
                    cornerRadius = CornerRadius(radius = 8.0),
                    size = Size(width = 45.unitPercent(), height =  40.unitPercent()),
                    flex = Flex(alignSelf = AlignSelf.CENTER)
                )
            )
        )
    ).applyStyle(
        Style(
            size = Size(width = 80.unitPercent(), height = 100.unitReal()),
            flex = Flex(
                alignSelf = AlignSelf.CENTER,
                flexDirection = FlexDirection.ROW
            ),
            cornerRadius = CornerRadius(radius = 10.0),
            backgroundColor = "#061a24"
        )
    )
}