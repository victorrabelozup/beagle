//
//  Stack.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Stack: NativeWidget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    
    // MARK: - Initialization
    
    init(
        children: [Widget] = []
    ) {
        self.children = children
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
        children = childrenBuilder()
    }
    
}
