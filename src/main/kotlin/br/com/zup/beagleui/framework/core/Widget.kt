package br.com.zup.beagleui.framework.core

data class Padding(
    val top: UnitValue? = null,
    val left: UnitValue? = null,
    val right: UnitValue? = null,
    val bottom: UnitValue? = null
)

data class Layout(
    val width: UnitValue? = null,
    val maxWidth: UnitValue? = null,
    val minWidth: UnitValue? = null,
    val height: UnitValue? = null,
    val maxHeight: UnitValue? = null,
    val minHeight: UnitValue? = null,
    val aspectRatio: Double? = null,
    val padding: Padding? = null
)

abstract class Widget {
    abstract fun build(): Widget
}