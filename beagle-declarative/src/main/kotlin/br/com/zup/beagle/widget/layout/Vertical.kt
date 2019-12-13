package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class Vertical(
    val children: List<Widget>,
    val reversed: Boolean? = null
) : Widget
