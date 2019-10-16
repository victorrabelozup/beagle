package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.NativeWidget
import br.com.zup.beagleui.framework.core.UnitValue
import br.com.zup.beagleui.framework.core.Widget

data class PaddingValue(
    val top: UnitValue? = null,
    val left: UnitValue? = null,
    val right: UnitValue? = null,
    val bottom: UnitValue? = null
)

data class Padding(
    val value: PaddingValue,
    val child: Widget
) : NativeWidget()
