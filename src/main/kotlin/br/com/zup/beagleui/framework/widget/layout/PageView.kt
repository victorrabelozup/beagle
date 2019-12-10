package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Widget

interface PageIndicatorWidget : Widget

data class PageView(
    val pages: List<Widget>,
    val pageIndicator: PageIndicatorWidget? = null
) : Widget
