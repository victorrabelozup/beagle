//
//  Horizontal.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Horizontal: Widget {
    
    let children: [Widget]
    let flex: Flex?
    let reversed: Bool
    
    init(
        children: [Widget] = [],
        flex: Flex? = nil,
        reversed: Bool = false
    ) {
        self.children = children
        self.flex = flex
        self.reversed = reversed
    }
    
}
