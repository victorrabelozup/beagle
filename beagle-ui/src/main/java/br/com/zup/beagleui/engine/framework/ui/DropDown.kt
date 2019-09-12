package br.com.zup.beagleui.engine.framework.ui

import br.com.zup.beagleui.engine.framework.core.Widget

data class DropDown(
    val header: Widget,
    val child: Widget
) : Widget