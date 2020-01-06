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
    
    init(
        appearance: Appearance? = nil,
        children: [Widget] = []
    ) {
        self.appearance = appearance
        self.children = children
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(appearance: appearance, children: [singleChild])
    }
    
    public static func new(
        appearance: Appearance? = nil,
        closure: () -> Widget
    ) -> Stack {
        let singleChild = closure()
        return .init(appearance: appearance, children: [singleChild])
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(appearance: appearance, children: children)
    }
    
    public static func new(
        appearance: Appearance? = nil,
        closure: () -> [Widget]
    ) -> Stack {
        let children = closure()
        return .init(appearance: appearance, children: children)
    }
    
}
