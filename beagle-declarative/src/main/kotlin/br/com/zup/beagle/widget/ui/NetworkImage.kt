package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.core.Widget

data class NetworkImage(
    val url: String,
    val contentMode: ImageContentMode? = null /* = ImageContentMode.FIT_CENTER */
) : Widget