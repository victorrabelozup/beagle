//
//  VerticalEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct VerticalEntity: WidgetConvertibleEntity {
    
    let children: [AnyDecodableContainer]
    var reversed: Bool = false
    
    func mapToWidget() throws -> Widget {

        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }

        return Vertical(
            children: children,
            reversed: reversed
        )
    }
}
