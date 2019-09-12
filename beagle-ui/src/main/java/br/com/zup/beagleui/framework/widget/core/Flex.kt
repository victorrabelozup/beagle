package br.com.zup.beagleui.framework.widget.core

data class Flex (
    val itemDirection: ItemDirection = ItemDirection.LTR,
    val flexWrap: FlexWrap = FlexWrap.NO_WRAP,
    val justifyContent: JustifyContent = JustifyContent.FLEX_START,
    val alignItems: Alignment = Alignment.STRETCH,
    val alignSelf: Alignment = Alignment.AUTO,
    val alignContent: Alignment = Alignment.FLEX_START,
    val basis: UnitValue = UnitValue(0.0, UnitType.REAL),
    val grow: Double = 0.0,
    val shrink: Int = 0
)

enum class ItemDirection {
    INHERIT,
    LTR,
    RTL
}

enum class FlexWrap {
    NO_WRAP,
    WRAP,
    WRAP_REVERSE
}

enum class JustifyContent {
    FLEX_START,
    CENTER,
    FLEX_END,
    SPACE_BETWEEN,
    SPACE_AROUND,
    SPACE_EVENLY
}

enum class Alignment {
    FLEX_START,
    CENTER,
    FLEX_END,
    SPACE_BETWEEN,
    SPACE_AROUND,
    BASELINE,
    AUTO,
    STRETCH
}
