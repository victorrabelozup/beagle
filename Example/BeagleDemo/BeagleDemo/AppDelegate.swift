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
        
        Beagle.start(appName: "BeagleTest")
        
//        let rootViewController = LayoutInclusionViewController()
        
        let someScreen = SomeScreen()
        let rootViewController = BeagleScreenViewController(screenType: .declarative(someScreen))
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}


struct SomeScreen: Screen {

    var content: FlexConfigurableWidget {
        FlexWidget {
            Text("Text 1")
        }.applyFlex(
            flexDirection: .column,
            justifyContent: .center,
            grow: 1.0
        )
    }

}
