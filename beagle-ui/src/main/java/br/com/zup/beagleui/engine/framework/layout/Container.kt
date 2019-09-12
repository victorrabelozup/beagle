package br.com.zup.beagleui.engine.framework.layout

import br.com.zup.beagleui.engine.framework.core.Widget

data class Container(
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : Widget