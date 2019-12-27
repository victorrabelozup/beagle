//
//  Navigator.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct Navigator: Widget {
    
    // MARK: - Public Properties
    
    public let action: Navigate
    public let child: Widget
    
    // MARK: - Initialization
    
    init(
        action: Navigate,
        child: Widget
    ) {
        self.action = action
        self.child = child
    }
    
    public init(
        action: Navigate,
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let child = childBuilder()
        self.init(action: action, child: child)
    }
}
