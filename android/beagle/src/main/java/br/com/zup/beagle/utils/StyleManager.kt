package br.com.zup.beagle.utils

import android.content.Context
import android.content.res.TypedArray
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import android.view.View
import br.com.zup.beagle.R
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class StyleManager(
    private val designSystem: DesignSystem? = BeagleEnvironment.beagleSdk.designSystem
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

    fun getTypedArray(
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

        return null
    }
}