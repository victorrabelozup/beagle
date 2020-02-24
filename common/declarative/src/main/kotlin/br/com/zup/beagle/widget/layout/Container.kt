package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget

data class Container(
    val children: List<ServerDrivenComponent>
) : Widget(), LayoutComponent
