package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Widget

data class Horizontal(
    val children: List<Widget>,
    val reversed: Boolean? = null
) : Widget
