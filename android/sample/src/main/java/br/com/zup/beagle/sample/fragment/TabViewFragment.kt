/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment

class TabViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = TabView(
            style = "DesignSystem.TabView.Custom",
            tabItems = listOf(
                buildTabView(
                    title = "Title 1",
                    content = Text("Content").applyFlex(
                        Flex(
                            margin = EdgeValue(
                                top = UnitValue(
                                    10.0,
                                    UnitType.REAL
                                )
                            )
                        )
                    )
                ),
                buildTabView(title = "Title 2", content = Button("button")),
                buildTabView(
                    title = "Title 3",
                    content = Container(
                        children = listOf(
                            Text("text tab 3", alignment = TextAlignment.CENTER)
                        )
                    )
                ),
                buildTabView(
                    title = "Title 4",
                    content =
                    Text("text").applyFlex(
                        Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        )
                    )
                ),
                buildTabView(
                    title = "Title 5",
                    content =
                    Text("text").applyFlex(
                        Flex(
                            justifyContent = JustifyContent.FLEX_START,
                            alignItems = Alignment.FLEX_END
                        )
                    )
                )
            )
        )

        return context?.let { declarative.toView(this) }
    }

    private fun buildTabView(title: String, content: ServerDrivenComponent): TabItem {
        return TabItem(
            title = title,
            content = content,
            icon = "ic_launcher_foreground"
        )
    }

    companion object {
        fun newInstance(): TabViewFragment {
            return TabViewFragment()
        }
    }
}