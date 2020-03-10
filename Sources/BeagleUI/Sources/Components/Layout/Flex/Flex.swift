//
//  Copyright © 12/09/19 Zup IT. All rights reserved.
//

public class Flex {

    public var direction: Direction?
    public var flexDirection: FlexDirection?
    public var flexWrap: Wrap?
    public var justifyContent: JustifyContent?
    public var alignItems: Alignment?
    public var alignSelf: Alignment?
    public var alignContent: Alignment?
    public var positionType: PositionType?
    public var basis: UnitValue?
    public var flex: Double?
    public var grow: Double?
    public var shrink: Double?
    public var display: Display?
    public var size: Size?
    public var margin: EdgeValue?
    public var padding: EdgeValue?
    public var position: EdgeValue?
    
    public init(
        direction: Flex.Direction? = nil,
        flexDirection: Flex.FlexDirection? = nil,
        flexWrap: Flex.Wrap? = nil,
        justifyContent: Flex.JustifyContent? = nil,
        alignItems: Flex.Alignment? = nil,
        alignSelf: Flex.Alignment? = nil,
        alignContent: Flex.Alignment? = nil,
        positionType: Flex.PositionType? = nil,
        basis: UnitValue? = nil,
        flex: Double? = nil,
        grow: Double? = nil,
        shrink: Double? = nil,
        display: Flex.Display? = nil,
        size: Size? = nil,
        margin: EdgeValue? = nil,
        padding: EdgeValue? = nil,
        position: EdgeValue? = nil
    ) {
        self.flexDirection = flexDirection
        self.direction = direction
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.alignSelf = alignSelf
        self.alignContent = alignContent
        self.positionType = positionType
        self.basis = basis
        self.flex = flex
        self.grow = grow
        self.shrink = shrink
        self.display = display
        self.size = size
        self.margin = margin
        self.padding = padding
        self.position = position
    }
}

// MARK: - Flex FlexDirection
extension Flex {
    public enum Direction: String, StringRawRepresentable {
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
}

// MARK: - Flex Direction
extension Flex {
    public enum FlexDirection: String, StringRawRepresentable {
        case row = "ROW"
        case rowReverse = "ROW_REVERSE"
        case column = "COLUMN"
        case columnReverse = "COLUMN_REVERSE"
    }
}

// MARK: - Flex Wrap
extension Flex {
    public enum Wrap: String, StringRawRepresentable {
        case noWrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrapReverse = "WRAP_REVERSE"
    }
}

// MARK: - Flex JustifyContent
extension Flex {
    public enum JustifyContent: String, StringRawRepresentable {
        case flexStart = "FLEX_START"
        case center = "CENTER"
        case flexEnd = "FLEX_END"
        case spaceBetween = "SPACE_BETWEEN"
        case spaceAround = "SPACE_AROUND"
        case spaceEvenly = "SPACE_EVENLY"
    }
}

// MARK: - Flex Alignment
extension Flex {
    public enum Alignment: String, StringRawRepresentable {
        case flexStart = "FLEX_START"
        case center = "CENTER"
        case flexEnd = "FLEX_END"
        case spaceBetween = "SPACE_BETWEEN"
        case spaceAround = "SPACE_AROUND"
        case baseline = "BASELINE"
        case auto = "AUTO"
        case stretch = "STRETCH"
    }
}

// MARK: - Flex Display
extension Flex {
    public enum Display: String, StringRawRepresentable {
        case flex = "FLEX"
        case none = "NONE"
    }
}

// MARK: - Position
extension Flex {
    public enum PositionType: String, StringRawRepresentable {
        case relative = "RELATIVE"
        case absolute = "ABSOLUTE"
    }
}
