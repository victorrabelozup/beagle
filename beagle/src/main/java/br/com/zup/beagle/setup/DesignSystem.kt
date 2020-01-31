package br.com.zup.beagle.setup

import androidx.annotation.DrawableRes
import androidx.annotation.StyleRes

interface DesignSystem {
    @DrawableRes fun image(name: String): Int
    @StyleRes fun theme(): Int
    @StyleRes fun textAppearance(name: String): Int
    @StyleRes fun buttonStyle(name: String): Int
    @StyleRes fun toolbarStyle(name: String): Int
}