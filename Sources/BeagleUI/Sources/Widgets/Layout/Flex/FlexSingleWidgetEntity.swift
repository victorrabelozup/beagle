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
    var appearance: AppearanceEntity?
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        let flex = try self.flex.mapToUIModel()
        let appearance = try self.appearance?.mapToUIModel()
        
        return FlexSingleWidget(
            child: child,
            flex: flex,
            appearance: appearance
        )
    }
}
