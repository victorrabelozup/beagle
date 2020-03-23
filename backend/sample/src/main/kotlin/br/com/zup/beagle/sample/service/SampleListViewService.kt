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
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleListViewService {
    fun createListView(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle ListView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "ListView",
                            message = "Is a Layout component that will define a list of views natively. " +
                                "These views could be any Server Driven Component.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = ScrollView(
                scrollDirection = ScrollAxis.VERTICAL,
                children = listOf(
                    getStaticVerticalListView(),
                    Spacer(20.0),
                    getStaticHorizontalListView(),
                    Spacer(20.0),
                    getDynamicVerticalListView(),
                    Spacer(20.0),
                    getDynamicHorizontalListView()
                )
            )
        )
    }

    private fun getStaticVerticalListView(): Container {
        return Container(
            children = listOf(
                Text("Static Vertical ListView"),
                Spacer(10.0),
                ListView(
                    rows = listOf(
                        Text("Hello 1"),
                        Text("Hello 2"),
                        Text("Hello 3"),
                        Text("Hello 4"),
                        Text("Hello 5"),
                        Text("Hello 6"),
                        Text("Hello 7"),
                        Text("Hello 8"),
                        Text("Hello 9"),
                        Text("Hello 10")
                    ),
                    direction = ListDirection.VERTICAL
                )
            )
        )
    }

    private fun getStaticHorizontalListView(): Container {
        return Container(
            children = listOf(
                Text("Static Horizontal ListView"),
                Spacer(10.0),
                ListView(
                    rows = listOf(
                        Text("Hello 1"),
                        Text("Hello 2"),
                        Text("Hello 3"),
                        Text("Hello 4"),
                        Text("Hello 5"),
                        Text("Hello 6"),
                        Text("Hello 7"),
                        Text("Hello 8"),
                        Text("Hello 9"),
                        Text("Hello 10")
                    ),
                    direction = ListDirection.HORIZONTAL
                )
            )
        )
    }

    private fun getDynamicVerticalListView(): Container {
        return Container(
            children = listOf(
                Text("Dynamic Vertical ListView"),
                Spacer(10.0),
                ListView.dynamic(
                    size = 20,
                    direction = ListDirection.VERTICAL,
                    rowBuilder = { index ->
                        Text("Hello $index")
                    }
                )
            )
        )
    }

    private fun getDynamicHorizontalListView(): Container {
        return Container(
            children = listOf(
                Text("Dynamic Horizontal ListView"),
                Spacer(10.0),
                ListView.dynamic(
                    size = 20,
                    direction = ListDirection.HORIZONTAL,
                    rowBuilder = { index ->
                        Text("Hello $index")
                    }
                )
            )
        )
    }
}
