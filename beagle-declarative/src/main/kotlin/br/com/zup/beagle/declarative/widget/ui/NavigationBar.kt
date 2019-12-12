package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.Widget

data class NavigationBar(
    val title: String,
    val leading: Widget? = null,
    val trailing: Widget? = null
) : Widget