package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.Widget

data class Text(
    val text: String,
    val style: String? = null,
    val alignment: TextAlignment? = null,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget

enum class TextAlignment {
    LEFT,
    CENTER,
    RIGHT
}