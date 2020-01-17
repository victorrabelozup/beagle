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
    
    public init(
        children: [Widget],
        flex: Flex = Flex(),
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.flex = flex
        self.appearance = appearance
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> FlexWidget {
        return FlexWidget(children: children, flex: flex)
    }
    
}
