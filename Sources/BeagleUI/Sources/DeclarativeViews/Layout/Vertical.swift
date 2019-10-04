//
//  Vertical.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Vertical: LayoutWidget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public let reversed: Bool
    
    // MARK: - Initialization
    
    init(
        children: [Widget] = [],
        reversed: Bool = false
    ) {
        self.children = children
        self.reversed = reversed
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild])
    }
    
    public init(
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children)
    }
    
    // MARK: - Configuration
    
    public func reversed(_ reversed: Bool = true) -> Horizontal {
        return Horizontal(children: children, reversed: reversed)
    }
    
}
