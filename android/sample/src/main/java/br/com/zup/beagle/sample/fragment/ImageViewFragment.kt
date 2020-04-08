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
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text

class ImageViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            child = Container(
                children = listOf(
                    NetworkImage(
                        path = "https://cdn-images-1.medium.com/max/1200/1*kjiNJPB3Y-ZVmjxco_bORA.png"
                    ).applyFlex(
                        Flex(
                            margin = EdgeValue(top = 10.unitReal())
                            //size = Size(width = 100.unitReal(), height = 100.unitReal())
                        )
                    ).applyAppearance(
                        Appearance(
                            cornerRadius = CornerRadius(30.0)
                        )
                    ),
                    Text(text = "Opa!!!")
                )
            )
        )

        return declarative.toView(this)
    }

    companion object {
        fun newInstance(): ImageViewFragment {
            return ImageViewFragment()
        }
    }
}