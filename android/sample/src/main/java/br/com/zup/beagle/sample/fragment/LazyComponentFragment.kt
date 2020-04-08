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
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.lazy.LazyComponent
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text

class LazyComponentFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            navigationBar = NavigationBar(title = "List"),
            child = Container(children = listOf(buildScrollView())).applyFlex(Flex(grow = 1.0))
        )
        return declarative.toView(this)
    }

    private fun buildScrollView() = ScrollView(
        children = listOf(
            NetworkImage(
                path = "https://www.petlove.com.br/images/breeds/193436/profile/original/beagle-p.jpg?1532538271"
            ).applyAppearance(Appearance(cornerRadius = CornerRadius(30.0))),
            LazyComponent(
                path = "http://www.mocky.io/v2/5e4e91c02f00001f2016a8f2",
                initialState = Text("Loading LazyComponent...")
            )
        )
    )

    companion object {
        fun newInstance(): LazyComponentFragment {
            return LazyComponentFragment()
        }
    }
}
