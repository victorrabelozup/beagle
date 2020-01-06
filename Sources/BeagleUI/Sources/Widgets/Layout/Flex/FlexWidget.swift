//
//  FlexWidget.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexWidget: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let children: [Widget]
    public let flex: Flex
    
    // MARK: - Initialization
    
    init(
        children: [Widget],
        flex: Flex = Flex(),
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.flex = flex
        self.appearance = appearance
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild], appearance: appearance)
    }
    
    public static func new(
        appearance: Appearance? = nil,
        closure: () -> Widget
    ) -> FlexWidget {
        let children = closure()
        return .init(children: [children], appearance: appearance)
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children, appearance: appearance)
    }
    
    public static func new(
        appearance: Appearance? = nil,
        _ closure: () -> [Widget]
    ) -> FlexWidget {
        let children = closure()
        return .init(children: children, appearance: appearance)
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> FlexWidget {
        return FlexWidget(children: children, flex: flex)
    }
    
}
