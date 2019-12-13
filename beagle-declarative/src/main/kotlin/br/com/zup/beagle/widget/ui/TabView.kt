package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.Widget

data class TabView(
    val tabItems: List<TabItem>
) : Widget

data class TabItem(
    val title: String? = null,
    val content: Widget,
    val icon: String? = null
)