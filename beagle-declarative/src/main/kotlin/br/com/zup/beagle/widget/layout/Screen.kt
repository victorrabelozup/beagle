package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class SafeArea(
    val top: Boolean? = null,
    val leading: Boolean? = null,
    val bottom: Boolean? = null,
    val trailing: Boolean? = null
)

data class NavigationBar(
    val title: String,
    val showBackButton: Boolean? = null,
    val style: String? = null
)

data class Screen(
    val safeArea: SafeArea? = null,
    val navigationBar: NavigationBar? = null,
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
)