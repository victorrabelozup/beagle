package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.UnitValue
import br.com.zup.beagleui.framework.widget.core.Widget

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
