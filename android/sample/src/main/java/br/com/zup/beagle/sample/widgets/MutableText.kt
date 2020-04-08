/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.widgets

import android.content.Context
import android.graphics.Color
import android.widget.TextView
import br.com.zup.beagle.widget.core.WidgetView

data class MutableText(
    val firstText: String = "",
    val secondText: String = "",
    val color: String = "#000000"
): WidgetView() {
    override fun toView(context: Context) = TextView(context).apply {
        val color = Color.parseColor(color)
        text = firstText
        setTextColor(color)
        setOnClickListener {
            text = if (text == firstText)
                secondText
            else
                firstText
        }
    }
}