package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.NativeWidget

data class Text(
    val text: String,
    val style: String? = null
) : NativeWidget