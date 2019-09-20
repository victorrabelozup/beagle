//
//  HorizontalEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Horizontal`
struct HorizontalEntity: WidgetEntity {
    let children: [WidgetEntityContainer]?
    let flex: FlexEntity?
    let reversed: Bool = false
}
extension HorizontalEntity: WidgetConvertible, ChildrenWidgetMapping {
    
    func mapToWidget() throws -> Widget {
        
        let children: [Widget]? = try mapChildren()
        let flex = try self.flex?.mapToUIModel()
        
        return Horizontal(
            children: children,
            flex: flex,
            reversed: reversed
        )
        
    }
}
