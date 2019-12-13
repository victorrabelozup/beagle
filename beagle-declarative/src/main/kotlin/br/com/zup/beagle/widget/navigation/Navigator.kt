package br.com.zup.beagle.widget.navigation

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.widget.core.Widget

data class Navigator(
    val action: Navigate,
    val child: Widget
) : Widget