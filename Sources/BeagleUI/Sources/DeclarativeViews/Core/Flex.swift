//
//  Flex.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Flex {
    
    // MARK: - Public Properties
    
    public let direction: Direction
    public let flexDirection: FlexDirection
    public let flexWrap: Wrap
    public let justifyContent: JustifyContent
    public let alignItems: Alignment
    public let alignSelf: Alignment
    public let alignContent: Alignment
    public let basis: UnitValue
    public let flex: Double
    public let grow: Double
    public let shrink: Double
    public let display: Display
    public let size: Size
    public let margin: EdgeValue
    public let padding: EdgeValue
    public let position: EdgeValue
    
    // MARK: - Initialization
    
    public init (
        direction: Direction = .ltr,
        flexDirection: FlexDirection = .column,
        flexWrap: Wrap = .noWrap,
        justifyContent: JustifyContent = .flexStart,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flexStart,
        basis: UnitValue = .zero,
        flex: Double = .zero,
        grow: Double = .zero,
        shrink: Double = .zero,
        display: Display = .none,
        size: Size = Size(),
        margin: EdgeValue = EdgeValue(),
        padding: EdgeValue = EdgeValue(),
        position: EdgeValue = EdgeValue()
    ) {
        self.flexDirection = flexDirection
        self.direction = direction
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.alignSelf = alignSelf
        self.alignContent = alignContent
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

// MARK: - Flex Size
extension Flex {
    public struct Size {
        
        // MARK: - Public Properties
        
        public let width: UnitValue?
        public let height: UnitValue?
        public let maxWidth: UnitValue?
        public let maxHeight: UnitValue?
        public let minWidth: UnitValue?
        public let minHeight: UnitValue?
        public let aspectRatio: Double?
        
        // MARK: - Initialization
        
        public init(
            width: UnitValue? = nil,
            height: UnitValue? = nil,
            maxWidth: UnitValue? = nil,
            maxHeight: UnitValue? = nil,
            minWidth: UnitValue? = nil,
            minHeight: UnitValue? = nil,
            aspectRatio: Double? = nil
        ) {
            self.width = width
            self.height = height
            self.maxWidth = maxWidth
            self.maxHeight = maxHeight
            self.minWidth = minWidth
            self.minHeight = minHeight
            self.aspectRatio = aspectRatio
        }
        
    }
}

// MARK: - EdgeValue
extension Flex {
    public struct EdgeValue {
        
        // MARK: - Public Properties
        
        public let left: UnitValue?
        public let top: UnitValue?
        public let right: UnitValue?
        public let bottom: UnitValue?
        public let start: UnitValue?
        public let end: UnitValue?
        public let horizontal: UnitValue?
        public let vertical: UnitValue?
        public let all: UnitValue?
        
        // MARK: - Initialization
        
        public init(
            left: UnitValue? = nil,
            top: UnitValue? = nil,
            right: UnitValue? = nil,
            bottom: UnitValue? = nil,
            start: UnitValue? = nil,
            end: UnitValue? = nil,
            horizontal: UnitValue? = nil,
            vertical: UnitValue? = nil,
            all: UnitValue? = nil
        ) {
            self.left = left
            self.top = top
            self.right = right
            self.bottom = bottom
            self.start = start
            self.end = end
            self.horizontal = horizontal
            self.vertical = vertical
            self.all = all
        }
        
    }
}
