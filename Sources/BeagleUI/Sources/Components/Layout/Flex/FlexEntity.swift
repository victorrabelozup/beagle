//
//  Flex.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct FlexEntity: Decodable {
    var flexDirection: FlexDirection?
    var direction: Direction?
    var flexWrap: FlexWrap?
    var justifyContent: JustifyContent?
    var alignItems: Alignment?
    var alignSelf: Alignment?
    var alignContent: Alignment?
    var positionType: PositionType?
    var basis: UnitValueEntity?
    var flex: Double?
    var grow: Double?
    var shrink: Double?
    var display: Display?
    var size: Size?
    var margin: EdgeValue?
    var padding: EdgeValue?
    var position: EdgeValue?
}

extension FlexEntity {
    
    struct Size: Decodable {
        var width: UnitValueEntity?
        var height: UnitValueEntity?
        var maxWidth: UnitValueEntity?
        var maxHeight: UnitValueEntity?
        var minWidth: UnitValueEntity?
        var minHeight: UnitValueEntity?
        var aspectRatio: Double?
    }
    
    struct EdgeValue: Decodable {
        var left: UnitValueEntity?
        var top: UnitValueEntity?
        var right: UnitValueEntity?
        var bottom: UnitValueEntity?
        var start: UnitValueEntity?
        var end: UnitValueEntity?
        var horizontal: UnitValueEntity?
        var vertical: UnitValueEntity?
        var all: UnitValueEntity?
    }
    
    enum FlexDirection: String, Decodable, UIEnumModelConvertible {
        case row = "ROW"
        case rowReverse = "ROW_REVERSE"
        case column = "COLUMN"
        case columnReverse = "COLUMN_REVERSE"
    }
    
    enum Direction: String, Decodable, UIEnumModelConvertible {
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
    
    enum FlexWrap: String, Decodable, UIEnumModelConvertible {
        case noWrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrapReverse = "WRAP_REVERSE"
    }
    
    enum JustifyContent: String, Decodable, UIEnumModelConvertible {
        case flexStart = "FLEX_START"
        case center = "CENTER"
        case flexEnd = "FLEX_END"
        case spaceBetween = "SPACE_BETWEEN"
        case spaceAround = "SPACE_AROUND"
        case spaceEvenly = "SPACE_EVENLY"
    }
    
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
    
    enum PositionType: String, Decodable, UIEnumModelConvertible {
        case relative = "RELATIVE"
        case absolute = "ABSOLUTE"
    }
    
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
