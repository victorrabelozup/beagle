package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import br.com.zup.beagleui.framework.widget.core.Widget

data class NetworkImage(
    val url: String,
    val contentMode: ImageContentMode = ImageContentMode.FIT_CENTER
) : Widget
