//
//  VerticalEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Vertical`
struct VerticalEntity: WidgetEntity {
    
    let children: [WidgetConvertibleEntity]
    let flex: FlexEntity
    let reversed: Bool
    
    private let childrenContainer: [WidgetEntityContainer]
    
    private enum CodingKeys: String, CodingKey {
        case childrenContainer = "children"
        case flex
        case reversed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            childrenContainer: container.decode([WidgetEntityContainer].self, forKey: .childrenContainer),
            flex: container.decodeIfPresent(FlexEntity.self, forKey: .flex),
            reversed: container.decodeIfPresent(Bool.self, forKey: .reversed)
        )
    }
    
    init(
        childrenContainer: [WidgetEntityContainer],
        flex: FlexEntity?,
        reversed: Bool?
    ) {
        self.childrenContainer = childrenContainer
        children = childrenContainer.compactMap { $0.content }
        self.flex = flex ?? FlexEntity()
        self.reversed = reversed ?? false
    }
    
}
extension VerticalEntity: WidgetConvertible, ChildrenWidgetMapping {

    func mapToWidget() throws -> Widget {

        let children = try mapChildren()
        let flex = try self.flex.mapToUIModel()

        return Vertical(
            children: children,
            flex: flex,
            reversed: reversed
        )
        
    }

}
