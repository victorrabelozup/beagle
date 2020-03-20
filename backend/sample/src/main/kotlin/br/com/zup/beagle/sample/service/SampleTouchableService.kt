/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BEACH_NETWORK_IMAGE
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_STYLE
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.navigation.Touchable
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleTouchableService {
    fun createTouchableView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Beagle Touchable",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Touchable",
                            message = "Applies cl" +
                                "ick action on widgets that have no action.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = Container(
                children = listOf(
                    touchableCustom(title = "Text with Touchable", item = Text("Click Aqui!")),
                    touchableCustom(title = "Image with Touchable", item = Image(LOGO_BEAGLE)),
                    networkImageTouchable()
                )
            )
        )
    }

    private fun touchableCustom(item: Widget, title: String): ServerDrivenComponent {
        return Container(
            children = listOf(
                buildTitle(
                    text = title
                ),
                Touchable(
                    action = Navigate(
                        path = SCREEN_ACTION_CLICK_ENDPOINT,
                        type = NavigationType.ADD_VIEW
                    ), child = item.applyFlex(
                        flex = Flex(
                            alignSelf = Alignment.CENTER,
                            margin = EdgeValue(
                                top = 8.unitReal(),
                                bottom = 8.unitReal()
                            )
                        )
                    )
                )
            )
        )
    }

    private fun buildTitle(text: String) = Text(
        text = text,
        style = SCREEN_TEXT_STYLE
    ).applyFlex(
        flex = Flex(
            alignSelf = Alignment.CENTER,
            margin = EdgeValue(
                top = 8.unitReal()
            )
        )
    )

    private fun networkImageTouchable(): ServerDrivenComponent {
        return Container(
            children = listOf(
                buildTitle(
                    "NetworkImage with Touchable"
                ),
                Touchable(
                    child = NetworkImage(
                        path = BEACH_NETWORK_IMAGE
                    ).applyFlex(
                        flex = Flex(
                            size = Size(
                                width = 150.unitReal(),
                                height = 130.unitReal()
                            ),
                            alignSelf = Alignment.CENTER
                        )
                    ),
                    action = Navigate(
                        path = SCREEN_ACTION_CLICK_ENDPOINT,
                        type = NavigationType.ADD_VIEW
                    )
                )
            )
        )

    }
}
