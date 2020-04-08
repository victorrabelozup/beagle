/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.view

import android.content.Context
import androidx.viewpager.widget.ViewPager
import br.com.zup.beagle.widget.pager.PageIndicatorOutput

class BeaglePageView(context: Context) : ViewPager(context), PageIndicatorOutput {

    override fun swapToPage(newIndex: Int) {
        setCurrentItem(newIndex, true)
    }
}
