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
public struct Beagle {
    
    // MARK: - Private Properties
    
    static var didCallStart: Bool = false
    
    // MARK: - Dependencies
    
    /// Defines a, internal point of access to the beagle environment as a type
    static var environment: BeagleEnvironmentProtocol.Type = BeagleEnvironment.self
    
    // MARK: - Public Functions
    
    /// Starts the application, setting up it's environment based on the appName
    public static func start(
        appName: String = "Beagle",
        networkingDispatcher: URLRequestDispatching? = nil,
        appBundle: Bundle? = nil,
        deepLinkHandler: BeagleDeepLinkScreenManaging? = nil,
        applicationTheme: Theme? = nil,
        validatorHandler: ValidatorHandler? = nil,
        customActionHandler: CustomActionHandler? = nil
        ) {
        guard didCallStart == false else {
            fatalError("Beagle.start should be called only one time!")
        }
        didCallStart = true
        environment.initialize(appName: appName, networkingDispatcher: networkingDispatcher, appBundle: appBundle, deepLinkHandler: deepLinkHandler, applicationTheme: applicationTheme, validatorHandler: validatorHandler, customActionHandler: customActionHandler)
    }
    
    /// Register a single custom widget and entity
    public static func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>) {
        environment.shared.registerCustomWidget(item)
    }
    
    /// Configure a global theme
    public static func configureTheme(_ theme: Theme) {
        environment.shared.configureTheme(theme)
    }
    
    /// Configure a global validator handler
    public static func configureValidatorHandler(_ validatorHandler: ValidatorHandler) {
        environment.shared.configureValidatorHandler(validatorHandler)
    }
    
    /// Configure a global custom action handler
    public static func configureCustomActionHandler(_ customActionHandler: CustomActionHandler) {
        environment.shared.configureCustomActionHandler(customActionHandler)
    }
}
