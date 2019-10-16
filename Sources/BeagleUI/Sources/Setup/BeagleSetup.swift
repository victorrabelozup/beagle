//
//  BeagleSetup.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines the Beagle namespace
public final class Beagle {
    
    /// Defines a, internal point of access to the beagle environment as a type
    static var environment: BeagleEnvironmentProtocol.Type = BeagleEnvironment.self
    
    /// Starts the application, setting up it's environment based on the appName
    public class func start(appName: String = "Beagle") {
        environment.initialize(appName: appName)
    }
    
    /// Register a single custom widget and entity
    public class func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>) {
        environment.shared.registerCustomWidget(item)
    }
    
}
