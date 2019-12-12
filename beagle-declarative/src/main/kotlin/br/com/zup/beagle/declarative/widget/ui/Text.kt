package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.Widget

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