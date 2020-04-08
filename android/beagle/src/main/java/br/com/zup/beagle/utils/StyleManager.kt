/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import android.content.Context
import android.content.res.TypedArray
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import android.util.TypedValue
import android.view.View
import br.com.zup.beagle.R
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class StyleManager(
    private val designSystem: DesignSystem? = BeagleEnvironment.beagleSdk.designSystem,
    private val typedValue: TypedValue = TypedValue()
) {

    fun getBackgroundColor(
        context: Context,
        component: ServerDrivenComponent,
        view: View
    ): Int? {
        return if (view.background == null) {
            Color.TRANSPARENT
        } else when (component) {
            is Text -> fetchDrawableColor(
                getTypedArray(
                    context,
                    designSystem?.textAppearance(component.style ?: ""),
                    R.styleable.BackgroundStyle
                )
            )
            is Button -> fetchDrawableColor(
                getTypedArray(
                    context,
                    designSystem?.buttonStyle(component.style ?: ""),
                    R.styleable.BackgroundStyle
                )
            )
            else -> fetchDrawableColor(background = view.background)
        }
    }

    fun getTypedValueByResId(resId: Int, context: Context): TypedValue {
        context.theme.resolveAttribute(resId, typedValue, true)
        return typedValue
    }

    fun getButtonStyle(style: String?): Int? {
        return designSystem?.buttonStyle(style ?: "")
    }

    fun getButtonTypedArray(context: Context, style: String?): TypedArray? {
        val buttonStyle = getButtonStyle(style)
        return getTypedArray(
            context,
            buttonStyle,
            R.styleable.BeagleButtonStyle
        )
    }

    fun getTabBarTypedArray(context: Context, style: String?): TypedArray? {
        val tabStyle = designSystem?.tabBarStyle(style ?: "")
        return getTypedArray(
            context,
            tabStyle,
            R.styleable.BeagleTabBarStyle
        )
    }

    private fun getTypedArray(
        context: Context,
        style: Int?,
        attrStyles: IntArray
    ): TypedArray? {
        var typedArray: TypedArray? = null
        if (designSystem != null && style != null) {
            typedArray = context.obtainStyledAttributes(style, attrStyles)
        }

        return typedArray
    }

    private fun fetchDrawableColor(
        typedArray: TypedArray? = null,
        background: Drawable? = null
    ): Int? {
        val drawable =
            typedArray?.getDrawable(R.styleable.BackgroundStyle_android_background) ?: background
        if (drawable is ColorDrawable) {
            return drawable.color
        }
        typedArray?.recycle()
        return null
    }
}