package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class TabView(
    val tabItems: List<TabItem>
) : Widget

data class TabItem(
    val title: String? = null,
    val content: Widget,
    val icon: String? = null
)