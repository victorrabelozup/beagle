package br.com.zup.beagleui.framework.widget.core

data class Flex (
    val flexDirection: FlexDirection = FlexDirection.COLUMN,
    val direction: Direction = Direction.LTR,
    val flexWrap: FlexWrap = FlexWrap.NO_WRAP,
    val justifyContent: JustifyContent = JustifyContent.FLEX_START,
    val alignItems: Alignment = Alignment.STRETCH,
    val alignSelf: Alignment = Alignment.AUTO,
    val alignContent: Alignment = Alignment.FLEX_START,
    val positionType: FlexPositionType = FlexPositionType.RELATIVE,
    val basis: UnitValue = UnitValue(0.0, UnitType.AUTO),
    val flex: Double = 0.0,
    val grow: Double = 0.0,
    val shrink: Double = 1.0,
    val display: FlexDisplay = FlexDisplay.FLEX,
    val size: Size = Size(),
    val margin: EdgeValue = EdgeValue(),
    val padding: EdgeValue = EdgeValue(),
    val position: EdgeValue = EdgeValue()
)

data class Size (
    val width: UnitValue? = null,
    val height: UnitValue? = null,
    val maxWidth: UnitValue? = null,
    val maxHeight: UnitValue? = null,
    val minWidth: UnitValue? = null,
    val minHeight: UnitValue? = null,
    val aspectRatio: Double? = null
)

data class EdgeValue(
    val left: UnitValue? = null,
    val top: UnitValue? = null,
    val right: UnitValue? = null,
    val bottom: UnitValue? = null,
    val start: UnitValue? = null,
    val end: UnitValue? = null,
    val horizontal: UnitValue? = null,
    val vertical: UnitValue? = null,
    val all: UnitValue? = null
)

enum class FlexDirection {
    COLUMN,
    ROW,
    COLUMN_REVERSE,
    ROW_REVERSE
}

enum class Direction {
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

enum class FlexDisplay {
    FLEX,
    NONE
}

enum class FlexPositionType {
    ABSOLUTE,
    RELATIVE
}
