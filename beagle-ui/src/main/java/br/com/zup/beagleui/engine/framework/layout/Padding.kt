package br.com.zup.beagleui.engine.framework.layout

import br.com.zup.beagleui.engine.framework.core.UnitValue
import br.com.zup.beagleui.engine.framework.core.Widget

data class PaddingValue(
    val top: UnitValue? = null,
    val left: UnitValue? = null,
    val right: UnitValue? = null,
    val bottom: UnitValue? = null
)

data class Padding(
    val value: PaddingValue,
    val child: Widget
) : Widget
