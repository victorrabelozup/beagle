//
//  BeagleSetup.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import Networking

/// Defines the Beagle namespace
public final class Beagle {
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Dependencies
    
    /// Defines a, internal point of access to the beagle environment as a type
    static var environment: BeagleEnvironmentProtocol.Type = BeagleEnvironment.self
    
    // MARK: - Public Functions
    
    /// Starts the application, setting up it's environment based on the appName
    public class func start(appName: String = "Beagle", networkingDispatcher: URLRequestDispatching? = nil) {
        environment.initialize(appName: appName, networkingDispatcher: networkingDispatcher)
    }
    
    /// Register a single custom widget and entity
    public class func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>) {
        environment.shared.registerCustomWidget(item)
    }
    
}
