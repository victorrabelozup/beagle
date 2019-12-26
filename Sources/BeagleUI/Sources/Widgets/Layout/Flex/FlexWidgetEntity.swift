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
    
    func mapToWidget() throws -> Widget {
        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        let flex = try self.flex?.mapToUIModel() ?? Flex()
        
        return FlexWidget(
            children: children,
            flex: flex
        )
    }
}
