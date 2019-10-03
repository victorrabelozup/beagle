//
//  PaddingEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Padding`
struct PaddingEntity: WidgetEntity {
    
    let value: PaddingValueEntity
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case value
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            value: container.decodeIfPresent(PaddingValueEntity.self, forKey: .value),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        value: PaddingValueEntity?,
        childContainer: WidgetEntityContainer
    ) throws {
        self.value = value ?? PaddingValueEntity(
            top: .default,
            left: .default,
            right: .default,
            bottom: .default
        )
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: PaddingEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
    }
    
}
extension PaddingEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        let value = try mapPaddingValue()
        let child = try self.child.mapToWidget()
        
        return Padding(value: value, child: child)
    }
    
    private func mapPaddingValue() throws -> Padding.Value {
        
        let top = try value.top?.mapToUIModel()
        let left = try value.left?.mapToUIModel()
        let right = try value.right?.mapToUIModel()
        let bottom = try value.bottom?.mapToUIModel()
        
        return Padding.Value(
            top: top ?? .default,
            left: left ?? .default,
            right: right ?? .default,
            bottom: bottom ?? .default
        )
    }
    
}

/// Defines an API representation for `PaddingValue`
struct PaddingValueEntity: WidgetEntity {
    let top: UnitValueEntity?
    let left: UnitValueEntity?
    let right: UnitValueEntity?
    let bottom: UnitValueEntity?
}
