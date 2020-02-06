package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.widget.core.Widget

data class Button(
    val text: String,
    val style: String? = null,
    val action: Action? = null
) : Widget