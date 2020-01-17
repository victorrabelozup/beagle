//
//  HorizontalEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct HorizontalEntity: WidgetConvertibleEntity {
    
    var appearance: AppearanceEntity?
    var children: [AnyDecodableContainer] = []
    var reversed: Bool = false

    init(
        appearance: AppearanceEntity? = nil,
        children: [AnyDecodableContainer] = [],
        reversed: Bool = false
    ) {
        self.appearance = appearance
        self.children = children
        self.reversed = reversed
    }
    
    func mapToWidget() throws -> Widget {
        
        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        return Horizontal(
            appearance: try appearance?.mapToUIModel(),
            children: children,
            reversed: reversed
        )
    }
}
