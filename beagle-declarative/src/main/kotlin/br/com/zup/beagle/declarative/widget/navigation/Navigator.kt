package br.com.zup.beagle.declarative.widget.navigation

import br.com.zup.beagle.declarative.action.Navigate
import br.com.zup.beagle.declarative.widget.core.Widget

data class Navigator(
    val action: Navigate,
    val child: Widget
) : Widget