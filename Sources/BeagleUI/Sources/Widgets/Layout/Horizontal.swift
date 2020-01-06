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
    
    init(
        appearance: Appearance? = nil,
        children: [Widget] = [],
        reversed: Bool = false
    ) {
        self.appearance = appearance
        self.children = children
        self.reversed = reversed
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
    ) -> Horizontal {
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
        closure: () -> [Widget]
    ) -> Horizontal {
        let children = closure()
        return .init(children: children)
    }
    
    // MARK: - Configuration
    
    public func reversed(_ reversed: Bool = true) -> Horizontal {
        return Horizontal(children: children, reversed: reversed)
    }
    
}
