package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

internal data class ScreenComponent(
    val navigationBar: NavigationBar? = null,
    val header: ServerDrivenComponent? = null,
    val content: ServerDrivenComponent,
    val footer: ServerDrivenComponent? = null
) : ServerDrivenComponent, LayoutComponent
