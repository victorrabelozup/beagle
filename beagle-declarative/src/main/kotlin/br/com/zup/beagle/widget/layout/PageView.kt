package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.pager.PageIndicatorWidget

data class PageView(
    val pages: List<Widget>,
    val pageIndicator: PageIndicatorWidget? = null
) : Widget
