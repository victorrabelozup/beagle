//
//  ScrollViewEntity.swift
//  BeagleUI
//
//  Created by Tarcisio Clemente on 06/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ScrollViewEntity: WidgetConvertibleEntity {
    
    let children: [AnyDecodableContainer]
    
    func mapToWidget() throws -> Widget {

        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }

        return ScrollView(
            children: children
        )
    }
}
