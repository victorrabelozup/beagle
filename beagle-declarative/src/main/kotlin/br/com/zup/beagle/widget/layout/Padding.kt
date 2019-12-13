package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.core.UnitValue

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
