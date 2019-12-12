package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.Widget

data class Button(
    val text: String,
    val style: String? = null
) : Widget