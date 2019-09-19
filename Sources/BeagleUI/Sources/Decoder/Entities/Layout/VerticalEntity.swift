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
extension VerticalEntity: WidgetConvertible, ChildWidgetMapping {

    func mapToWidget() throws -> Widget {

        let children = try mapChildren()

        return Vertical(
            children: children,
            flex: nil, // TODO: DEAL WITH FLEX LATER
            reversed: reversed
        )
        
    }

}
