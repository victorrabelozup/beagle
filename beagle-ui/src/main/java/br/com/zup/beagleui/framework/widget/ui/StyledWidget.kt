package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class Border (
    val color: Long? = null,
    val radius: Double? = null,
    val size: Double? = null
)

data class StyledWidget (
    val border: Border? = null,
    val color: Long? = null,
    val child: Widget
) : Widget
