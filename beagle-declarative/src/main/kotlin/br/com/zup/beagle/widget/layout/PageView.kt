package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

interface PageIndicatorWidget : Widget

data class PageView(
    val pages: List<Widget>,
    val pageIndicator: PageIndicatorWidget? = null
) : Widget
