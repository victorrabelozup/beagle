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

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.TITLE_SCREEN
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleImageService {
    fun createImageView(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle Image",
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
                children = listOf(
                    Text(text = "Image", style = TITLE_SCREEN),

                    Image(name = LOGO_BEAGLE),

                    Text(
                        text = "Image with contentMode = ImageContentMode.CENTER",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.CENTER),

                    Text(
                        text = "Image with contentMode = ImageContentMode.CENTER_CROP",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.CENTER_CROP),

                    Text(
                        text = "Image with contentMode = ImageContentMode.FIT_CENTER",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.FIT_CENTER),

                    Text(
                        text = "Image with contentMode = ImageContentMode.FIT_XY",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.FIT_XY)
                )
            )
        )
    }
}
