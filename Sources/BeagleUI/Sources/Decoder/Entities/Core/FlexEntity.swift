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
    
    let itemDirection: ItemDirection
    let flexWrap: Wrap
    let justifyContent: JustifyContent
    let alignItems: Alignment
    let alignSelf: Alignment
    let alignContent: Alignment
    let basis: UnitValueEntity
    let grow: Double
    let shrink: Int
    
    private enum CodingKeys: String, CodingKey {
        case itemDirection
        case flexWrap
        case justifyContent
        case alignItems
        case alignSelf
        case alignContent
        case basis
        case grow
        case shrink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            itemDirection: container.decodeIfPresent(ItemDirection.self, forKey: .itemDirection),
            flexWrap: container.decodeIfPresent(Wrap.self, forKey: .flexWrap),
            justifyContent: container.decodeIfPresent(JustifyContent.self, forKey: .justifyContent),
            alignItems: container.decodeIfPresent(Alignment.self, forKey: .alignItems),
            alignSelf: container.decodeIfPresent(Alignment.self, forKey: .alignSelf),
            alignContent: container.decodeIfPresent(Alignment.self, forKey: .alignContent),
            basis: container.decodeIfPresent(UnitValueEntity.self, forKey: .basis),
            grow: container.decodeIfPresent(Double.self, forKey: .grow),
            shrink: container.decodeIfPresent(Int.self, forKey: .shrink)
        )
    }
    
    init(
        itemDirection: ItemDirection? = nil,
        flexWrap: Wrap? = nil,
        justifyContent: JustifyContent? = nil,
        alignItems: Alignment? = nil,
        alignSelf: Alignment? = nil,
        alignContent: Alignment? = nil,
        basis: UnitValueEntity? = nil,
        grow: Double? = nil,
        shrink: Int? = nil
    ) {
        self.itemDirection = itemDirection ?? .ltr
        self.flexWrap = flexWrap ?? .no_wrap
        self.justifyContent = justifyContent ?? .flex_start
        self.alignItems = alignItems ?? .stretch
        self.alignSelf = alignSelf ?? .auto
        self.alignContent = alignContent ?? .flex_start
        self.basis = basis ?? UnitValueEntity(value: .zero, type: .real)
        self.grow = grow ?? 0.0
        self.shrink = shrink ?? 0
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
    /// Defines an API representation for `ItemDirection`
    enum ItemDirection: String, WidgetEntity, UIEnumModelConvertible {
        case inherit
        case ltr
        case rtl
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexDirection`
    enum Direction: String, WidgetEntity, UIEnumModelConvertible {
        case row
        case row_reverse
        case column
        case column_reverse
    }
}

extension FlexEntity {
    /// Defines an API representation for `FlexWrap`
    enum Wrap: String, WidgetEntity, UIEnumModelConvertible {
        case no_wrap
        case wrap
        case wrap_reverse
    }
}

extension FlexEntity {
    /// Defines an API representation for `JustifyContent`
    enum JustifyContent: String, WidgetEntity, UIEnumModelConvertible {
        case flex_start
        case center
        case flex_end
        case space_between
        case space_around
        case space_evenly
    }
}

extension FlexEntity {
    /// Defines an API representation for `Alignement`
    enum Alignment: String, WidgetEntity, UIEnumModelConvertible {
        case flex_start
        case center
        case flex_end
        case space_between
        case space_around
        case baseline
        case auto
        case stretch
    }
}
