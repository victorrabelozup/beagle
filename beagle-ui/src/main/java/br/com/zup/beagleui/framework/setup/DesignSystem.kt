package br.com.zup.beagleui.framework.setup

import androidx.annotation.DrawableRes
import androidx.annotation.StyleRes

interface DesignSystem {
    @DrawableRes fun image(name: String): Int
    @StyleRes fun theme(): Int
    @StyleRes fun textAppearance(name: String): Int
    fun buttonStyle(name: String): ButtonStyle
}

data class ButtonStyle(
    @field:StyleRes val textAppearance: Int,
    @field:StyleRes val background: Int
)