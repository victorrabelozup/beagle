package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.NativeWidget

data class Button(
    val text: String,
    val style: String? = null
) : NativeWidget()