//
//  StackEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Stack`
struct StackEntity: WidgetEntity {
    let children: [WidgetEntityContainer]
    let flex: FlexEntity?
}
extension StackEntity: WidgetConvertible, ChildrenWidgetMapping {
    
    func mapToWidget() throws -> Widget {
        
        let children = try mapChildren() ?? []
        let flex = try self.flex?.mapToUIModel()
        
        return Stack(
            children: children,
            flex: flex
        )
        
    }
    
}
