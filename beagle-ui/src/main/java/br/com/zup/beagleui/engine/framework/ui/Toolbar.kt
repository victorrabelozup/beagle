package br.com.zup.beagleui.engine.framework.ui

import br.com.zup.beagleui.engine.framework.core.Widget

data class Toolbar(
    val title: String,
    val showBackButton: Boolean = true
) : Widget