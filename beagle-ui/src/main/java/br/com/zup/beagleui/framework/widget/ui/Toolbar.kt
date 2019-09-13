package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class Toolbar(
    val title: String,
    val showBackButton: Boolean = true
) : Widget
