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
    let children: [WidgetEntityContainer]
    let flex: FlexEntity?
    let reversed: Bool = false
}
extension VerticalEntity: WidgetConvertible, ChildrenWidgetMapping {

    func mapToWidget() throws -> Widget {

        guard let children = try mapChildren() else {
            let type = String(describing: VerticalEntity.self)
            throw WidgetConvertibleError.couldNotFindChildrenPropertyForType(type)
        }
        
        let flex: Flex? = nil // TODO: DEAL WITH FLEX LATER

        return Vertical(
            children: children,
            flex: flex,
            reversed: reversed
        )
        
    }

}
