//
//  BeagleSetup.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public final class Beagle {
    
    static var environment: BeagleEnvironmentProtocol.Type = BeagleEnvironment.self
    
    public class func start(
        appName: String
    ) {
        environment.initialize(appName: appName, decoder: nil)
    }
    
    public class func registerCustomWidgets<T: WidgetEntity>(_ items: WidgetRegisterItem<T>...) {
        environment.shared.registerCustomWidgets(items)
    }
    
    public class func registerCustomWidgets<T: WidgetEntity>(_ item: WidgetRegisterItem<T>) {
        environment.shared.registerCustomWidgets([item])
    }
    
}
