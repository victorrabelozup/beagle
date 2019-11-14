//
//  Screen.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

/// Defines some Beagle Screen, that is rendered from widgets
public protocol Screen {
    
    /// A Content represents something that has a Flex positioning/configuration
    /// system, and Widget representable views.
    var content: Widget { get }
}
