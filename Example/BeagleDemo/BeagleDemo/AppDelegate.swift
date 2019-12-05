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
        
        Beagle.start(appName: "BeagleDemo", deepLinkHandler: deepLinkHandler)
        
        let rootViewController = BeagleScreenViewController(screenType: .declarative(MainScreen().widget))
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        return true
    }
}
