/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.view

import android.content.Context
import android.view.Gravity
import androidx.appcompat.widget.AppCompatTextView
import androidx.core.widget.TextViewCompat
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.utils.toAndroidColor
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment

internal class BeagleTextView(context: Context) : AppCompatTextView(context), OnStateUpdatable<Text> {
    override fun onUpdateState(widget: Text) {
        this.setTextWidget(widget)
    }
}

internal fun BeagleTextView.setTextWidget(text: Text) {
    this.text = text.text
    this.setStyle(text.style ?: "")
    this.setTextColor(text.textColor)
    this.setAlignment(text.alignment)
}

private fun BeagleTextView.setAlignment(alignment: TextAlignment?) {
    when (alignment) {
        TextAlignment.CENTER -> this.gravity = Gravity.CENTER
        TextAlignment.RIGHT -> this.gravity = Gravity.END
        else -> this.gravity = Gravity.START
    }
}

private fun BeagleTextView.setStyle(style: String) {
    val designSystem = BeagleEnvironment.beagleSdk.designSystem
    if (designSystem != null) {
        val styleRes = designSystem.textAppearance(style)
        TextViewCompat.setTextAppearance(this, styleRes)
    }
}

private fun BeagleTextView.setTextColor(color: String?) {
    color?.let {
        this.setTextColor(color.toAndroidColor())
    }
}