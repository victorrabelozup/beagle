//
//  FlexSingleWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FlexSingleWidgetEntity: WidgetConvertibleEntity {
    
    let child: AnyDecodableContainer
    var flex: FlexEntity = FlexEntity()
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        let flex = try self.flex.mapToUIModel()
        
        return FlexSingleWidget(
            child: child,
            flex: flex
        )
    }
}
