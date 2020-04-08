/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.view

import android.content.Context
import android.view.View
import android.webkit.WebView
import android.widget.FrameLayout
import android.widget.HorizontalScrollView
import android.widget.ScrollView
import androidx.appcompat.app.AlertDialog
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.widget.core.Flex

internal class ViewFactory {

    fun makeView(context: Context) = View(context)

    fun makeBeagleView(context: Context) =
        BeagleView(context = context)

    fun makeBeagleFlexView(context: Context) =
        BeagleFlexView(context = context)

    fun makeBeagleFlexView(context: Context, flex: Flex) =
        BeagleFlexView(context = context, flex = flex)

    fun makeScrollView(context: Context) =
        ScrollView(context).apply {
            isFillViewport = true
        }

    fun makeHorizontalScrollView(context: Context) =
        HorizontalScrollView(context).apply {
            isFillViewport = true
        }

    fun makeButton(context: Context) = BeagleButtonView(context)

    fun makeTextView(context: Context) = BeagleTextView(context)

    fun makeImageView(context: Context) = BeagleImageView(context)

    fun makeRecyclerView(context: Context) = RecyclerView(context)

    fun makeAlertDialogBuilder(context: Context) = AlertDialog.Builder(context)

    fun makeFrameLayoutParams(width: Int, height: Int) = FrameLayout.LayoutParams(width, height)

    fun makeViewPager(context: Context) = BeaglePageView(context)

    fun makePageIndicator(context: Context) = BeaglePageIndicatorView(context)

    fun makeTabLayout(context: Context) = BeagleTabLayout(context)

    fun makeWebView(context: Context) = WebView(context)
}
