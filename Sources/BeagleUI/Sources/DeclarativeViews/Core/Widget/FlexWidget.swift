//
//  FlexWidget.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexWidget: FlexConfigurableWidget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public var flex: Flex {
        return _flex
    }
    
    // MARK: - Private Properties
    
    private let _flex: Flex
    
    // MARK: - Initialization
    
    init(
        children: [Widget],
        flex: Flex = Flex()
    ) {
        self.children = children
        self._flex = flex
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
    
    public func applyFlex(_ flex: Flex = Flex()) -> FlexWidget {
        return FlexWidget(children: children, flex: flex)
    }
    
}
