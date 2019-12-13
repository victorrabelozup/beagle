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
            .deepLinkHandler(deepLinkHandler)

        Beagle.dependencies = dependencies
        
        let rootViewController = BeagleScreenViewController(screen: .declarative(MainScreen().widget))
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        return true
    }
}
