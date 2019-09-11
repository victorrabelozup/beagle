package br.com.zup.beagleui.framework.core

data class UnitValue(
    val value: Double,
    val type: UnitType
)

enum class UnitType {
    REAL,
    PERCENT
}