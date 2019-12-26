package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class NavigationBar(
    val title: String,
    val showBackButton: Boolean? = null
)

data class Screen(
    val navigationBar: NavigationBar? = null,
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
)