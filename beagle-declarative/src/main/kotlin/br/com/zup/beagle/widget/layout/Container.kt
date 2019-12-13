package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class Container(
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : Widget