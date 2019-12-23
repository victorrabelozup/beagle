//
//  AppDelegate.swift
//  BeagleDemo
//
//  Created by Daniel Tes on 10/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//
import UIKit
import BeagleUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let deepLinkHandler = DeeplinkScreenManager.shared
        deepLinkHandler["lazywidget"] = LazyWidgetScreen.self
        deepLinkHandler["pageview"] = PageViewScreen.self
        

        let dependencies = BeagleDependencies(appName: "BeagleDemo")
        dependencies.deepLinkHandler = deepLinkHandler
        Beagle.dependencies = dependencies
        
        let rootViewController = BeagleScreenViewController(screenType: .declarative(TabViewScreen().content))
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        return true
    }
    
}
