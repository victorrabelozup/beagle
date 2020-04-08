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
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Text

class StackViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Stack(
            children = listOf(
                Text("Text 1").applyFlex(Flex(margin = EdgeValue(top = UnitValue(5.0, UnitType.REAL)))),
                Text("Text 2"),
                Text("Text 3")
            )
        )

        return context?.let { declarative.toView(this) }
    }

    companion object {

        fun newInstance(): StackViewFragment {
            return StackViewFragment()
        }
    }
}
