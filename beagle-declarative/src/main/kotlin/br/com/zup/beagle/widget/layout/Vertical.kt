package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.Widget

data class Vertical(
    val children: List<Widget>,
    val reversed: Boolean? = null,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget
