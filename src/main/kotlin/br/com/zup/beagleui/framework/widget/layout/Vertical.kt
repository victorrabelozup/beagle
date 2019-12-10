package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Widget

data class Vertical(
    val children: List<Widget>,
    val reversed: Boolean? = null
) : Widget
