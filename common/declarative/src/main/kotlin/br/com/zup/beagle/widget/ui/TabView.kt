package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.core.ServerDrivenComponent

data class TabView(
    val tabItems: List<TabItem>,
    val style: String? = null
) : ServerDrivenComponent

data class TabItem(
    val title: String? = null,
    val content: ServerDrivenComponent,
    val icon: String? = null
)