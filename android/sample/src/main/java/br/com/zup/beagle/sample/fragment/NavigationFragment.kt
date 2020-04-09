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
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.analytics.ClickEvent
import br.com.zup.beagle.analytics.ScreenEvent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.navigation.Touchable
import br.com.zup.beagle.widget.ui.Button

class NavigationFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            child = Container(children = buildChildren()).applyFlex(
                Flex(
                    flexDirection = FlexDirection.COLUMN,
                    justifyContent = JustifyContent.CENTER,
                    alignItems = Alignment.CENTER,
                    alignContent = Alignment.SPACE_BETWEEN,
                    grow = 1.0
                )
            ),
            screenAnalyticsEvent = ScreenEvent(
                screenName = "Tela De Navegacao"
            )
        )

        return declarative.toView(this)
    }

    private fun buildChildren(): List<ServerDrivenComponent> {
        return listOf(
            Touchable(
                child = Button(text = "Click to navigate").applyFlex(
                    Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
                ),
                action = Navigate(
                    type = NavigationType.ADD_VIEW,
                    path = "https://t001-2751a.firebaseapp.com/flow/step1.json"
                ),
                clickAnalyticsEvent = ClickEvent(
                    category = "Categoria",
                    label = "Descrição",
                    value = "Valor"
                )
            )
        )
    }

    companion object {
        fun newInstance(): NavigationFragment {
            return NavigationFragment()
        }
    }
}