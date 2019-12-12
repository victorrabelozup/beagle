package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class Text(
    val text: String,
    val style: String? = null,
    val alignment: TextAlignment? = null
) : Widget

enum class TextAlignment {
    LEFT,
    CENTER,
    RIGHT
}
