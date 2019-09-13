package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Widget

data class Container(
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : Widget
