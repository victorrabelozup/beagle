package br.com.zup.beagleui.framework.widget.core

data class UnitValue(
    val value: Double,
    val type: UnitType
)

enum class UnitType {
    REAL,
    PERCENT
}
