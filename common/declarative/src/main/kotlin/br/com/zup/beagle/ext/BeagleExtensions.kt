package br.com.zup.beagle.ext

import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue

fun Int.unitReal() = UnitValue(this.toDouble(), UnitType.REAL)
fun Int.unitPercent() = UnitValue(this.toDouble(), UnitType.PERCENT)

fun Double.unitReal() = UnitValue(this, UnitType.REAL)
fun Double.unitPercent() = UnitValue(this, UnitType.PERCENT)