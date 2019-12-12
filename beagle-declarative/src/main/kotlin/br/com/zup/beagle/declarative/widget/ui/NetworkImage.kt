package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.ImageContentMode
import br.com.zup.beagle.declarative.widget.core.Widget

data class NetworkImage(
    val url: String,
    val contentMode: ImageContentMode? = null /* = ImageContentMode.FIT_CENTER */
) : Widget