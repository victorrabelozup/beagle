//
//  Flex.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Flex`
struct FlexEntity: Decodable {
    let flexDirection: FlexDirection?
    let direction: Direction?
    let flexWrap: FlexWrap?
    let justifyContent: JustifyContent?
    let alignItems: Alignment?
    let alignSelf: Alignment?
    let alignContent: Alignment?
    let positionType: PositionType?
    let basis: UnitValueEntity?
    let flex: Double?
    let grow: Double?
    let shrink: Double?
    let display: Display?
    let size: Size?
    let margin: EdgeValue?
    let padding: EdgeValue?
    let position: EdgeValue?
    
    init(
        flexDirection: FlexEntity.FlexDirection? = nil,
        direction: FlexEntity.Direction? = nil,
        flexWrap: FlexEntity.FlexWrap? = nil,
        justifyContent: FlexEntity.JustifyContent? = nil,
        alignItems: FlexEntity.Alignment? = nil,
        alignSelf: FlexEntity.Alignment? = nil,
        alignContent: FlexEntity.Alignment? = nil,
        positionType: FlexEntity.PositionType? = nil,
        basis: UnitValueEntity? = nil,
        flex: Double? = nil,
        grow: Double? = nil,
        shrink: Double? = nil,
        display: FlexEntity.Display? = nil,
        size: FlexEntity.Size? = nil,
        margin: FlexEntity.EdgeValue? = nil,
        padding: FlexEntity.EdgeValue? = nil,
        position: FlexEntity.EdgeValue? = nil
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

// MARK: - Flex Size
extension FlexEntity {
    /// Defines an API representation for `Size`
    struct Size: Decodable {
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
    struct EdgeValue: Decodable {
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

extension FlexEntity {
    /// Defines an API representation for `FlexDirection`
    enum FlexDirection: String, Decodable, UIEnumModelConvertible {
        case row = "ROW"
        case rowReverse = "ROW_REVERSE"
        case column = "COLUMN"
        case columnReverse = "COLUMN_REVERSE"
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexDirection`
    enum Direction: String, Decodable, UIEnumModelConvertible {
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexWrap`
    enum FlexWrap: String, Decodable, UIEnumModelConvertible {
        case noWrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrapReverse = "WRAP_REVERSE"
    }
}

extension FlexEntity {
    /// Defines an API representation for `JustifyContent`
    enum JustifyContent: String, Decodable, UIEnumModelConvertible {
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
    enum Alignment: String, Decodable, UIEnumModelConvertible {
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
    enum PositionType: String, Decodable, UIEnumModelConvertible {
        case relative = "RELATIVE"
        case absolute = "ABSOLUTE"
    }
}

extension FlexEntity {
    /// Defines an API representation for `Alignment`
    enum Display: String, Decodable, UIEnumModelConvertible {
        case flex = "FLEX"
        case none = "NONE"
    }
}

extension FlexEntity.Size: UIModelConvertible {
    typealias UIModelType = Flex.Size
    
    func mapToUIModel() throws -> Flex.Size {
        return Flex.Size(
            width: try self.width?.mapToUIModel(),
            height: try self.height?.mapToUIModel(),
            maxWidth: try self.maxWidth?.mapToUIModel(),
            maxHeight: try self.maxHeight?.mapToUIModel(),
            minWidth: try self.minWidth?.mapToUIModel(),
            minHeight: try self.minHeight?.mapToUIModel(),
            aspectRatio: self.aspectRatio
        )
    }
}

extension FlexEntity.EdgeValue: UIModelConvertible {
    typealias UIModelType = Flex.EdgeValue
    
    func mapToUIModel() throws -> Flex.EdgeValue {
        return Flex.EdgeValue(
            left: try self.left?.mapToUIModel(),
            top: try self.top?.mapToUIModel(),
            right: try self.right?.mapToUIModel(),
            bottom: try self.bottom?.mapToUIModel(),
            start: try self.start?.mapToUIModel(),
            end: try self.end?.mapToUIModel(),
            horizontal: try self.horizontal?.mapToUIModel(),
            vertical: try self.vertical?.mapToUIModel(),
            all: try self.all?.mapToUIModel()
        )
    }
}

extension FlexEntity: UIModelConvertible {
    
    typealias UIModelType = Flex

    func mapToUIModel() throws -> Flex {
        return Flex(
            direction: try self.direction?.mapToUIModel(ofType: Flex.Direction.self),
            flexDirection: try self.flexDirection?.mapToUIModel(ofType: Flex.FlexDirection.self),
            flexWrap: try self.flexWrap?.mapToUIModel(ofType: Flex.Wrap.self),
            justifyContent: try self.justifyContent?.mapToUIModel(ofType: Flex.JustifyContent.self),
            alignItems: try self.alignItems?.mapToUIModel(ofType: Flex.Alignment.self),
            alignSelf: try self.alignSelf?.mapToUIModel(ofType: Flex.Alignment.self),
            alignContent: try self.alignContent?.mapToUIModel(ofType: Flex.Alignment.self),
            positionType: try self.positionType?.mapToUIModel(ofType: Flex.PositionType.self),
            basis: try self.basis?.mapToUIModel(),
            flex: self.flex,
            grow: self.grow,
            shrink: self.shrink,
            display: try self.display?.mapToUIModel(ofType: Flex.Display.self),
            size: try self.size?.mapToUIModel(),
            margin: try self.margin?.mapToUIModel(),
            padding: try self.padding?.mapToUIModel(),
            position: try self.position?.mapToUIModel()
        )
    }

}
