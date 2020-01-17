//
//  Stack.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Stack: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let children: [Widget]
    
    // MARK: - Initialization
    
    public init(
        appearance: Appearance? = nil,
        children: [Widget] = []
    ) {
        self.appearance = appearance
        self.children = children
    }
    
}
