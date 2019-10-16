package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.NativeWidget

data class Button(
    val text: String,
    val style: String? = null
) : NativeWidget()