//
//  FlexSingleWidget.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexSingleWidget: FlexConfigurableWidget {
    
    // MARK: - Public Properties
    
    public let child: Widget
    public var flex: Flex {
        return _flex
    }
    
    // MARK: - Private Properties
    
    private let _flex: Flex
    
    // MARK: - Initialization
    
    init(
        child: Widget,
        flex: Flex = Flex()
    ) {
        self.child = child
        self._flex = flex
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let child = childBuilder()
        self.init(child: child)
    }
    
    // MARK: - Configuration
    
    func applyFlex(_ flex: Flex = Flex()) -> FlexSingleWidget {
        return FlexSingleWidget(child: child, flex: flex)
    }
    
}
