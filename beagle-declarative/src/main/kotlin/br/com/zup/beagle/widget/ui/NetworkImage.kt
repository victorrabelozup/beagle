package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.core.Widget

data class NetworkImage(
    val path: String,
    val contentMode: ImageContentMode? = null /* = ImageContentMode.FIT_CENTER */,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget