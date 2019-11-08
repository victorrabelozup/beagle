package br.com.zup.beagleui.framework.widget.navigation

import br.com.zup.beagleui.framework.action.Navigate
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class Navigator(
    val action: Navigate,
    val child: Widget
) : NativeWidget