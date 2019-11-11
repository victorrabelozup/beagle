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
        
        Beagle.start(appName: "BeagleDemo")
        
//        guard let url = URL(string: "http://localhost:8000/home.json") else {
//            fatalError()
//        }
//        let rootViewController = BeagleScreenViewController(screenType: .remote(url))
        
        let screen = ListViewScreen()
        let rootViewController = BeagleScreenViewController(screenType: .declarative(screen))
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

private class ListViewScreen: Screen {
    
    var content: Widget {
        FlexSingleWidget {
            ListView {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
                Text("Item 5")
                Text("Item 6")
                Text("Item 7")
                Text("Item 8")
                Text("Item 9")
                Text("Item 10")
                Text("Item 11")
                Text("Item 12")
                Text("Item 13")
                Text("Item 14")
                Text("Item 15")
                Text("Item 16")
                Text("Item 17")
                Text("Item 18")
                Text("Item 19")
                Text("Item 20")
            }
            .direction(.horizontal)
        }
    }
    
}
