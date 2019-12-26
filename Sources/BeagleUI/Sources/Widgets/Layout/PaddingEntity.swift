//
//  PaddingEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct PaddingEntity: WidgetEntity {
    
    var value: PaddingValueEntity = PaddingValueEntity(top: .zero, left: .zero, right: .zero, bottom: .zero)
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        
        let value = try mapPaddingValue()
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        
        return Padding(value: value, child: child)
    }
    
    private func mapPaddingValue() throws -> Padding.Value {
        
        let top = try value.top?.mapToUIModel()
        let left = try value.left?.mapToUIModel()
        let right = try value.right?.mapToUIModel()
        let bottom = try value.bottom?.mapToUIModel()
        
        return Padding.Value(
            top: top ?? .zero,
            left: left ?? .zero,
            right: right ?? .zero,
            bottom: bottom ?? .zero
        )
    }
}

struct PaddingValueEntity: WidgetEntity {
    let top: UnitValueEntity?
    let left: UnitValueEntity?
    let right: UnitValueEntity?
    let bottom: UnitValueEntity?
}
