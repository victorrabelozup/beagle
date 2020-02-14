package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.ImageContentMode

data class Image(
    val name: String,
    val contentMode: ImageContentMode? = null /* = ImageContentMode.FIT_CENTER */
) : Widget()