package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class NavigationBar(
    val title: String,
    val leading: Widget? = null,
    val trailing: Widget? = null
) : NativeWidget