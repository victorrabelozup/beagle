package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.Widget

data class NavigationBar(
    val title: String,
    val leading: Widget? = null,
    val trailing: Widget? = null
) : Widget