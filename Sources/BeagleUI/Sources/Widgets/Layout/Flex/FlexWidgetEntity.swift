//
//  FlexWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FlexWidgetEntity: WidgetConvertibleEntity {
    
    var children: [AnyDecodableContainer] = []
    var flex: FlexEntity?
    var appearance: AppearanceEntity?
    
    func mapToWidget() throws -> Widget {
        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        let flex = try self.flex?.mapToUIModel() ?? Flex()
        let appearance = try self.appearance?.mapToUIModel()
        
        return FlexWidget(
            children: children,
            flex: flex,
            appearance: appearance
        )
    }
}
