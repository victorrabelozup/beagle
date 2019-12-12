package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Widget
import br.com.zup.beagle.declarative.widget.core.UnitValue

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
