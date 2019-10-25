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
    
    public static func new(
        closure: () -> Widget
    ) -> Stack {
        let singleChild = closure()
        return .init(children: [singleChild])
    }
    
    public init(
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children)
    }
    
    public static func new(
        closure: () -> [Widget]
    ) -> Stack {
        let children = closure()
        return .init(children: children)
    }
    
}
