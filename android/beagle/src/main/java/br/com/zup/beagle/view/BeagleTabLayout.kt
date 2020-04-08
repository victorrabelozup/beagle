/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.view

import android.content.Context
import android.util.AttributeSet
import android.view.ViewGroup
import com.google.android.material.tabs.TabLayout


internal class BeagleTabLayout : TabLayout {

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    )

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        val tabLayout = getChildAt(0) as ViewGroup
        val childCount = tabLayout.childCount

        if (childCount != 0) {
            val displayMetrics = context.resources.displayMetrics
            val tabMinWidth = displayMetrics.widthPixels / childCount

            for (i in 0 until childCount) {
                tabLayout.getChildAt(i).minimumWidth = tabMinWidth
            }
        }

        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
    }
}