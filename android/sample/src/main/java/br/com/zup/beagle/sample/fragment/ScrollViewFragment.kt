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
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text

class ScrollViewFragment : Fragment() {

    private val flex = Flex(shrink = 0.0, margin = EdgeValue(all = UnitValue(50.0, UnitType.REAL)))

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            child = Container(
                children = listOf(
                    Text("1 Text\n2 Text\n3 Text\n4 Text\n5 Text\n6 Text\n7 Text\n8 Text\n9 Text\n10 Text.")
                        .applyFlex(Flex(shrink = 0.0)),
                    buildScrollView()
                )
            ).applyFlex(Flex(grow = 1.0))
        )

        return context?.let { declarative.toView(this) }
    }

    private fun buildScrollView() = ScrollView(
        children = listOf(
            NetworkImage(
                path = "https://www.petlove.com.br/images/breeds/193436/profile/original/beagle-p.jpg?1532538271"
            ).applyFlex(Flex(shrink = 0.0, size = Size(width = 200.unitReal(), height = 200.unitReal())))
                .applyAppearance(Appearance(cornerRadius = CornerRadius(30.0))),
            Text("Text 1").applyFlex(flex),
            Text("Text 2").applyFlex(flex),
            Text("Text 3").applyFlex(flex),
            Text("Text 4").applyFlex(flex),
            Text("Text 5").applyFlex(flex),
            Text("Text 6").applyFlex(flex),
            Text("Text 7").applyFlex(flex),
            Text("Text 8").applyFlex(flex),
            Text("Text 9").applyFlex(flex),
            Text("Text 10").applyFlex(flex)
        )
    )

    companion object {

        fun newInstance(): ScrollViewFragment {
            return ScrollViewFragment()
        }
    }
}