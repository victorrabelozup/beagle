package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class Spacer(
    val size: Double
) : ServerDrivenComponent, LayoutComponent