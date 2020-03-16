package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.Widget

data class Text(
    val text: String,
    val style: String? = null,
    val textColor: String? = null,
    val alignment: TextAlignment? = null
) : Widget()

enum class TextAlignment {
    LEFT,
    CENTER,
    RIGHT
}