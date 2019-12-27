//
//  FlexWidget.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexWidget: Widget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public let flex: Flex
    
    // MARK: - Initialization
    
    init(
        children: [Widget],
        flex: Flex = Flex()
    ) {
        self.children = children
        self.flex = flex
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild])
    }
    
    public static func new(
        closure: () -> Widget
    ) -> FlexWidget {
        let children = closure()
        return .init(children: [children])
    }
    
    public init(
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children)
    }
    
    public static func new(
        _ closure: () -> [Widget]
    ) -> FlexWidget {
        let children = closure()
        return .init(children: children)
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> FlexWidget {
        return FlexWidget(children: children, flex: flex)
    }
    
}
