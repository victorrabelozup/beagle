/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.pager

import android.content.Context
import android.graphics.Color
import br.com.zup.beagle.view.BeaglePageIndicatorView
import br.com.zup.beagle.view.ViewFactory

data class PageIndicator(
    val selectedColor: String,
    val unselectedColor: String
) : PageIndicatorComponent {

    @Transient
    private var viewFactory: ViewFactory = ViewFactory()
    @Transient
    private lateinit var pageIndicator: BeaglePageIndicatorView

    internal constructor(
        selectedColor: String,
        unselectedColor: String,
        viewFactory: ViewFactory
    ) : this(selectedColor, unselectedColor) {
        this.viewFactory = viewFactory
    }

    override fun toView(context: Context) = viewFactory.makePageIndicator(context).apply {
        pageIndicator = this
        setSelectedColor(Color.parseColor(selectedColor))
        setUnselectedColor(Color.parseColor(unselectedColor))
    }

    override fun setCount(pages: Int) {
        pageIndicator.setCount(pages)
    }

    override fun onItemUpdated(newIndex: Int) {
        pageIndicator.setCurrentIndex(newIndex)
    }

    override fun initPageView(pageIndicatorOutput: PageIndicatorOutput) {}
}