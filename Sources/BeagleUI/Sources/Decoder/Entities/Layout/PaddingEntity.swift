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
    let child: WidgetEntityContainer
}
extension PaddingEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        guard let childContent = child.content else {
            throw WidgetConvertibleError.emptyContentForContainerOfType(child.type)
        }
        
        let value = try mapPaddingValue()
        let child = try childContent.mapToWidget()
        
        return Padding(value: value, child: child)
    }
    
    private func mapPaddingValue() throws -> PaddingValue {
        
        let top = try value.top?.mapToUIModel()
        let left = try value.left?.mapToUIModel()
        let right = try value.right?.mapToUIModel()
        let bottom = try value.bottom?.mapToUIModel()
        
        return PaddingValue(
            top: top,
            left: left,
            right: right,
            bottom: bottom
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
