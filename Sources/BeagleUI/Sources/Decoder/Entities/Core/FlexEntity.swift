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
    let flexWrap: Wrap
    let justifyContent: JustifyContent
    let alignItems: Alignment
    let alignSelf: Alignment
    let alignContent: Alignment
    let basis: String
    let grow: Double
    let shrink: Int
}

extension FlexEntity: UIModelConvertible {
    
    typealias UIModelType = Flex

    func mapToUIModel() throws -> Flex {
        
        let flexWrap = try self.flexWrap.mapToUIModel(ofType: Flex.Wrap.self)
        let justifyContent = try self.justifyContent.mapToUIModel(ofType: Flex.JustifyContent.self)
        let alignItems = try self.alignItems.mapToUIModel(ofType: Flex.Alignment.self)
        let alignSelf = try self.alignSelf.mapToUIModel(ofType: Flex.Alignment.self)
        let alignContent = try self.alignContent.mapToUIModel(ofType: Flex.Alignment.self)
        
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
