//
//  Widget.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

/// Defines some component that can be rendered on a Screen
public protocol Widget {}

/// Defines a component that has a Flex based positioning configuration
public protocol FlexConfigurableWidget: Widget {
    var flex: Flex { get }
}

// Defines a representation of an unknwon Widget
struct AnyWidget: Widget {
    let value: Any
}
