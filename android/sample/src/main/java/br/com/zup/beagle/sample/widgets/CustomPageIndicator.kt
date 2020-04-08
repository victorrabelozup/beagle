/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.widgets

import br.com.zup.beagle.annotation.RegisterWidget
import android.content.Context
import android.view.View
import br.com.zup.beagle.sample.components.CustomPageIndicatorView
import br.com.zup.beagle.widget.pager.PageIndicatorOutput
import br.com.zup.beagle.widget.pager.PageIndicatorComponent

@RegisterWidget
data class CustomPageIndicator(
    val showContinue: Boolean,
    val showSkip: Boolean
) : PageIndicatorComponent {

    @Transient
    private lateinit var customPageIndicatorView: CustomPageIndicatorView
    @Transient
    private lateinit var output: PageIndicatorOutput

    override fun initPageView(pageIndicatorOutput: PageIndicatorOutput) {
        output = pageIndicatorOutput
    }

    override fun onItemUpdated(newIndex: Int) {
        customPageIndicatorView.setCurrentIndex(newIndex)
    }

    override fun setCount(pages: Int) {
        customPageIndicatorView.setCount(pages)
    }

    override fun toView(context: Context) = CustomPageIndicatorView(context).apply {
        customPageIndicatorView = this
        setIndexChangedListener { index ->
            output.swapToPage(index)
            setContinueButtonVisibility(
                if (showContinue) {
                    View.VISIBLE
                } else {
                    View.INVISIBLE
                }
            )
            setBackButtonVisibility(
                if (showSkip) {
                    View.VISIBLE
                } else {
                    View.INVISIBLE
                }
            )
        }
    }
}
