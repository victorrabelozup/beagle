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
    
    let children: [WidgetEntity]?
    let flex: FlexEntity?
    
    private let childrenContainer: [WidgetEntityContainer]?
    
    enum CodingKeys: String, CodingKey {
        case childrenContainer = "children"
        case flex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        childrenContainer = try container.decodeIfPresent([WidgetEntityContainer].self, forKey: .childrenContainer)
        children = childrenContainer?.compactMap { $0.content }
        flex = try container.decodeIfPresent(FlexEntity.self, forKey: .flex)
    }
    
    init(
        childrenContainer: [WidgetEntityContainer]?,
        flex: FlexEntity?
    ) {
        self.childrenContainer = childrenContainer
        children = childrenContainer?.compactMap { $0.content }
        self.flex = flex
    }
    
}
extension StackEntity: WidgetConvertible, ChildrenWidgetMapping {
    
    func mapToWidget() throws -> Widget {
        
        let children = try mapChildren()
        let flex = try self.flex?.mapToUIModel()
        
        return Stack(
            children: children,
            flex: flex
        )
        
    }
    
}
