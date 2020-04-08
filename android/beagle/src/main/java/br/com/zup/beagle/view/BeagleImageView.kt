/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.view

import android.content.Context
import android.graphics.Canvas
import androidx.appcompat.widget.AppCompatImageView
import br.com.zup.beagle.utils.applyRadius

internal class BeagleImageView(context: Context) : AppCompatImageView(context) {

    var cornerRadius = 0.0f

    override fun onDraw(canvas: Canvas?) {
        canvas?.applyRadius(cornerRadius)
        super.onDraw(canvas)
    }
}