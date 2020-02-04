package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.widget.core.Widget

data class SafeArea(
    val top: Boolean? = null,
    val leading: Boolean? = null,
    val bottom: Boolean? = null,
    val trailing: Boolean? = null
)

data class NavigationBarItem(
    val text: String,
    val image: String? = null,
    val action: Action
)

data class NavigationBar(
    val title: String,
    val showBackButton: Boolean? = null,
    val style: String? = null,
    val navigationBarItems: List<NavigationBarItem>? = null
)

data class Screen(
    val safeArea: SafeArea? = null,
    val navigationBar: NavigationBar? = null,
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
)