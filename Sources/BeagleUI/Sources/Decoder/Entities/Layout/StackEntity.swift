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
extension StackEntity: WidgetConvertible, ChildWidgetMapping {
    
    func mapToWidget() throws -> Widget {
        
        let children = try mapChildren()
        
        return Stack(
            children: children,
            flex: nil // TODO: DEAL WITH FLEX LATER
        )
        
    }
    
}
