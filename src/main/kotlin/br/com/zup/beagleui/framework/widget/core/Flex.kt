package br.com.zup.beagleui.framework.widget.core

data class Flex (
    val flexDirection: FlexDirection? = null, /* = FlexDirection.COLUMN */
    val direction: Direction? = null, /* = Direction.LTR */
    val flexWrap: FlexWrap? = null, /* = FlexWrap.NO_WRAP */
    val justifyContent: JustifyContent? = null, /* = JustifyContent.FLEX_START */
    val alignItems: Alignment? = null, /* = Alignment.STRETCH */
    val alignSelf: Alignment? = null, /* = Alignment.AUTO */
    val alignContent: Alignment? = null, /* = Alignment.FLEX_START */
    val positionType: FlexPositionType? = null, /* = FlexPositionType.RELATIVE */
    val basis: UnitValue? = null, /* = UnitValue(0.0, UnitType.AUTO) */
    val flex: Double? = null, /* = 0.0 */
    val grow: Double? = null, /* = 0.0 */
    val shrink: Double? = null, /* = 1.0 */
    val display: FlexDisplay? = null, /* = FlexDisplay.FLEX */
    val size: Size? = null,
    val margin: EdgeValue? = null,
    val padding: EdgeValue? = null,
    val position: EdgeValue? = null
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
