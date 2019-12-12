package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Widget

interface PageIndicatorWidget : Widget

data class PageView(
    val pages: List<Widget>,
    val pageIndicator: PageIndicatorWidget? = null
) : Widget
