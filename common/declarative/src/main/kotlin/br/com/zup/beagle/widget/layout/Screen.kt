package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent

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
    val showBackButton: Boolean = true,
    val style: String? = null,
    val navigationBarItems: List<NavigationBarItem>? = null
)

data class Screen(
    val safeArea: SafeArea? = null,
    val navigationBar: NavigationBar? = null,
    val header: ServerDrivenComponent? = null,
    val content: ServerDrivenComponent,
    val footer: ServerDrivenComponent? = null
)