//
//  Flex.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Flex`
struct FlexEntity: WidgetEntity {
    
    let flexDirection: Direction
    let direction: FlexDirection
    let flexWrap: Wrap
    let justifyContent: JustifyContent
    let alignItems: Alignment
    let alignSelf: Alignment
    let alignContent: Alignment
    let basis: UnitValueEntity
    let flex: Double
    let grow: Double
    let shrink: Double
    let display: Display
    let size: Size
    let margin: EdgeValue
    let padding: EdgeValue
    let position: Position
    
    private enum CodingKeys: String, CodingKey {
        case flexDirection
        case direction
        case flexWrap
        case justifyContent
        case alignItems
        case alignSelf
        case alignContent
        case basis
        case flex
        case grow
        case shrink
        case display
        case size
        case margin
        case padding
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            flexDirection: container.decodeIfPresent(Direction.self, forKey: .flexDirection),
            direction: container.decodeIfPresent(FlexDirection.self, forKey: .direction),
            flexWrap: container.decodeIfPresent(Wrap.self, forKey: .flexWrap),
            justifyContent: container.decodeIfPresent(JustifyContent.self, forKey: .justifyContent),
            alignItems: container.decodeIfPresent(Alignment.self, forKey: .alignItems),
            alignSelf: container.decodeIfPresent(Alignment.self, forKey: .alignSelf),
            alignContent: container.decodeIfPresent(Alignment.self, forKey: .alignContent),
            basis: container.decodeIfPresent(UnitValueEntity.self, forKey: .basis),
            flex: container.decodeIfPresent(Double.self, forKey: .flex),
            grow: container.decodeIfPresent(Double.self, forKey: .grow),
            shrink: container.decodeIfPresent(Double.self, forKey: .shrink),
            display: container.decodeIfPresent(Display.self, forKey: .display),
            size: container.decodeIfPresent(Size.self, forKey: .size),
            margin: container.decodeIfPresent(EdgeValue.self, forKey: .margin),
            padding: container.decodeIfPresent(EdgeValue.self, forKey: .padding),
            position: container.decodeIfPresent(Position.self, forKey: .position)
        )
    }
    
    init (
        flexDirection: Direction? = nil,
        direction: FlexDirection? = nil,
        flexWrap: Wrap? = nil,
        justifyContent: JustifyContent? = nil,
        alignItems: Alignment? = nil,
        alignSelf: Alignment? = nil,
        alignContent: Alignment? = nil,
        basis: UnitValueEntity? = nil,
        flex: Double? = nil,
        grow: Double? = nil,
        shrink: Double? = nil,
        display: Display? = nil,
        size: Size? = nil,
        margin: EdgeValue? = nil,
        padding: EdgeValue? = nil,
        position: Position? = nil
    ) {
        self.flexDirection = flexDirection ?? .column
        self.direction = direction ?? .ltr
        self.flexWrap = flexWrap ?? .noWrap
        self.justifyContent = justifyContent ?? .flexStart
        self.alignItems = alignItems ?? .stretch
        self.alignSelf = alignSelf ?? .auto
        self.alignContent = alignContent ?? .flexStart
        self.basis = basis ?? .zero
        self.flex = flex ?? .zero
        self.grow = grow ?? .zero
        self.shrink = shrink ?? .zero
        self.display = display ?? .none
        self.size = size ?? Size()
        self.margin = margin ?? EdgeValue()
        self.padding = padding ?? EdgeValue()
        self.position = position ?? .relative
    }
    
}

extension FlexEntity: UIModelConvertible {
    
    typealias UIModelType = Flex

    func mapToUIModel() throws -> Flex {
        
        let flexWrap = try self.flexWrap.mapToUIModel(ofType: Flex.Wrap.self)
        let justifyContent = try self.justifyContent.mapToUIModel(ofType: Flex.JustifyContent.self)
        let alignItems = try self.alignItems.mapToUIModel(ofType: Flex.Alignment.self)
        let alignSelf = try self.alignSelf.mapToUIModel(ofType: Flex.Alignment.self)
        let alignContent = try self.alignContent.mapToUIModel(ofType: Flex.Alignment.self)
        let basis = try self.basis.mapToUIModel()
        
        return Flex(
            flexWrap: flexWrap,
            justifyContent: justifyContent,
            alignItems: alignItems,
            alignSelf: alignSelf,
            alignContent: alignContent,
            basis: basis,
            grow: grow,
            shrink: shrink
        )
        
    }

}

extension FlexEntity {
    /// Defines an API representation for `FlexDirection`
    enum FlexDirection: String, WidgetEntity, UIEnumModelConvertible {
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexDirection`
    enum Direction: String, WidgetEntity, UIEnumModelConvertible {
        case row = "ROW"
        case rowReverse = "ROW_REVERSE"
        case column = "COLUMN"
        case columnReverse = "COLUMN_REVERSE"
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexWrap`
    enum Wrap: String, WidgetEntity, UIEnumModelConvertible {
        case noWrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrapReverse = "WRAP_REVERSE"
    }
}

extension FlexEntity {
    /// Defines an API representation for `JustifyContent`
    enum JustifyContent: String, WidgetEntity, UIEnumModelConvertible {
        case flexStart = "FLEX_START"
        case center = "CENTER"
        case flexEnd = "FLEX_END"
        case spaceBetween = "SPACE_BETWEEN"
        case spaceAround = "SPACE_AROUND"
        case spaceEvenly = "SPACE_EVENLY"
    }
}

extension FlexEntity {
    /// Defines an API representation for `Alignment`
    enum Alignment: String, WidgetEntity, UIEnumModelConvertible {
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

extension FlexEntity {
    /// Defines an API representation for `Alignment`
    enum Display: String, WidgetEntity, UIEnumModelConvertible {
        case flex = "FLEX"
        case none = "NONE"
    }
}

// MARK: - Flex Size
extension FlexEntity {
    /// Defines an API representation for `Size`
    struct Size: WidgetEntity {
        
        let width: UnitValueEntity?
        let height: UnitValueEntity?
        let maxWidth: UnitValueEntity?
        let maxHeight: UnitValueEntity?
        let minWidth: UnitValueEntity?
        let minHeight: UnitValueEntity?
        let aspectRatio: Double?
        
        init(
            width: UnitValueEntity? = nil,
            height: UnitValueEntity? = nil,
            maxWidth: UnitValueEntity? = nil,
            maxHeight: UnitValueEntity? = nil,
            minWidth: UnitValueEntity? = nil,
            minHeight: UnitValueEntity? = nil,
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
extension FlexEntity {
    /// Defines an API representation for `EdgeValue`
    struct EdgeValue: WidgetEntity {
        
        let left: UnitValueEntity?
        let top: UnitValueEntity?
        let right: UnitValueEntity?
        let bottom: UnitValueEntity?
        let start: UnitValueEntity?
        let end: UnitValueEntity?
        let horizontal: UnitValueEntity?
        let vertical: UnitValueEntity?
        let all: UnitValueEntity?
        
        init(
            left: UnitValueEntity? = nil,
            top: UnitValueEntity? = nil,
            right: UnitValueEntity? = nil,
            bottom: UnitValueEntity? = nil,
            start: UnitValueEntity? = nil,
            end: UnitValueEntity? = nil,
            horizontal: UnitValueEntity? = nil,
            vertical: UnitValueEntity? = nil,
            all: UnitValueEntity? = nil
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

// MARK: - Position
extension FlexEntity {
    public enum Position: String, WidgetEntity, UIEnumModelConvertible {
        case relative = "RELATIVE"
        case absolute = "ABSOLUTE"
    }
}
