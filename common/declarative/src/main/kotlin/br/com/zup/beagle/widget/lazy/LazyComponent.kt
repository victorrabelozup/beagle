package br.com.zup.beagle.widget.lazy

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class LazyComponent(
    val path: String,
    val initialState: ServerDrivenComponent
) : ServerDrivenComponent, LayoutComponent
