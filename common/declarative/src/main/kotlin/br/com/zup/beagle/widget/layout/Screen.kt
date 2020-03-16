package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.Appearance
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
    val action: Action,
    val accessibility: Accessibility? = null
)

data class NavigationBar(
    val title: String,
    val showBackButton: Boolean = true,
    val style: String? = null,
    val navigationBarItems: List<NavigationBarItem>? = null,
    val backButtonAccessibility: Accessibility? = null
)

data class Screen(
    val identifier: String? = null,
    val safeArea: SafeArea? = null,
    val navigationBar: NavigationBar? = null,
    val child: ServerDrivenComponent,
    val appearance: Appearance? = null
)