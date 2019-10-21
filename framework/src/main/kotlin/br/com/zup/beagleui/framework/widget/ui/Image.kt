package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import br.com.zup.beagleui.framework.widget.core.NativeWidget

data class Image(
    val name: String,
    val contentMode: ImageContentMode? = null /* = ImageContentMode.FIT_CENTER */
) : NativeWidget