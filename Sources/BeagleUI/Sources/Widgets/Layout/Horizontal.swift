//
//  Horizontal.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Horizontal: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let children: [Widget]
    public let reversed: Bool
    
    // MARK: - Initialization
    
    public init(
        appearance: Appearance? = nil,
        children: [Widget] = [],
        reversed: Bool = false
    ) {
        self.appearance = appearance
        self.children = children
        self.reversed = reversed
    }
    
    // MARK: - Configuration
    
    public func reversed(_ reversed: Bool = true) -> Horizontal {
        return Horizontal(children: children, reversed: reversed)
    }
    
}
