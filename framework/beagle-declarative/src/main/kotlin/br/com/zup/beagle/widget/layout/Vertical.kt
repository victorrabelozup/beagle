package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.ServerDrivenComponent

data class Vertical(
    val children: List<ServerDrivenComponent>,
    val reversed: Boolean? = null
) : ServerDrivenComponent
