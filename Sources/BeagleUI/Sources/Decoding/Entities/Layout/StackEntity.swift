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
    
    let children: [WidgetConvertibleEntity]
    
    private let childrenContainer: [WidgetEntityContainer]?
    
    private enum CodingKeys: String, CodingKey {
        case childrenContainer = "children"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            childrenContainer: container.decode([WidgetEntityContainer].self, forKey: .childrenContainer)
        )
    }
    
    init(childrenContainer: [WidgetEntityContainer]) {
        self.childrenContainer = childrenContainer
        children = childrenContainer.compactMap { $0.content }
    }
    
}
extension StackEntity: WidgetConvertible, ChildrenWidgetMapping {
    
    func mapToWidget() throws -> Widget {
        
        let children = try mapChildren()
        
        return Stack(children: children)
        
    }
    
}
