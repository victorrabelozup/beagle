package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.ContentMode
import br.com.zup.beagleui.framework.widget.core.NativeWidget

data class Image(
    val name: String,
    val contentMode: ContentMode? = null
) : NativeWidget