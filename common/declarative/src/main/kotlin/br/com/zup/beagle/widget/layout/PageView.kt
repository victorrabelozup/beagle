package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.pager.PageIndicatorWidget

data class PageView(
    val pages: List<ServerDrivenComponent>,
    val pageIndicator: PageIndicatorWidget? = null
) : Widget(), LayoutComponent
