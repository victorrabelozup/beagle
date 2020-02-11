package br.com.zup.beagle.widget.core

data class UnitValue(
    val value: Double,
    val type: UnitType
)

enum class UnitType {
    REAL,
    PERCENT,
    AUTO
}
