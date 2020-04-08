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
import br.com.zup.beagle.ext.unitPercent
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.WebView


class WebViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            child = WebView(
                url = "https://zup.com.br"
            ).applyFlex(
                Flex(
                    size = Size(
                        width = 100.unitPercent(),
                        height = 100.unitPercent()
                    )
                )
            )
        )
        return declarative.toView(this)
    }

    companion object {
        fun newInstance() = WebViewFragment()
    }
}