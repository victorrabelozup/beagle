//
//  Widget.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines some component that can be rendered on a Screen
public protocol Widget {
    func build() throws -> Widget
}

/// Defines some component that can be rendered on a Screen
public protocol NativeWidget: Widget {}
extension NativeWidget {
    public func build() throws -> Widget {
        throw unbuildableWidgetError
    }
}

private let unbuildableWidgetError = NSError(
    domain: "Widget",
    code: -1,
    description: "NativeWidgets don't need to be built!"
)

/// Defines a component that has a Flex based positioning configuration
public protocol FlexConfigurableWidget: NativeWidget {
    var flex: Flex { get }
}

// Defines a representation of an unknwon Widget
struct AnyWidget: Widget {
    
    let value: Any
    
    func build() throws -> Widget {
        guard let buildable = value as? Widget else {
            throw unbuildableWidgetError
        }
        
        return try buildable.build()
    }
    
}
