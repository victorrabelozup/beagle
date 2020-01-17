//
//  FlexSingleWidget.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexSingleWidget: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let child: Widget
    public let flex: Flex
    
    // MARK: - Initialization
    
    public init(
        child: Widget,
        flex: Flex = Flex(),
        appearance: Appearance? = nil
    ) {
        self.child = child
        self.flex = flex
        self.appearance = appearance
    }
    
    // MARK: - Configuration
    
    public func apply(_ flex: Flex) -> FlexSingleWidget {
        return FlexSingleWidget(child: child, flex: flex)
    }
    
}
