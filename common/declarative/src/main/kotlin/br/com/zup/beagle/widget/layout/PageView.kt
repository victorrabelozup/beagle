package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.pager.PageIndicatorComponent

data class PageView(
    val pages: List<ServerDrivenComponent>,
    val pageIndicator: PageIndicatorComponent? = null
) : ServerDrivenComponent, LayoutComponent
