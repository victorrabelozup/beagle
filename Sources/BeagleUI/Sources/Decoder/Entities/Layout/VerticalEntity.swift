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
    let children: [WidgetEntityContainer]?
    let flex: FlexEntity?
    let reversed: Bool
}
extension VerticalEntity: WidgetConvertible, ChildrenWidgetMapping {

    func mapToWidget() throws -> Widget {

        let children = try mapChildren()
        let flex = try self.flex?.mapToUIModel()

        return Vertical(
            children: children,
            flex: flex,
            reversed: reversed
        )
        
    }

}
