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

    var content: Widget {
        Container(
            header: {
                FlexWidget {
                    Text("Header")
                }.applyFlex(
                    direction: .ltr,
                    flexDirection: .column,
                    flexWrap: .noWrap,
                    justifyContent: .center,
                    alignItems: .center,
                    alignSelf: .auto,
                    alignContent: .center,
                    size: .init(width: .init(value: 100, type: .percent), height: .init(value: 140, type: .real))
                )
            },
            content: {
                FlexWidget(closure: {
                    var content = [Text]()
                    for i in stride(from: 0, through: 200, by: 1) {
                        content.append(Text("Content \(i+1)"))
                    }
                    return content
                })
                .applyFlex(
                    direction: .ltr,
                    flexDirection: .column,
                    flexWrap: .noWrap,
                    justifyContent: .center,
                    alignItems: .center,
                    alignSelf: .auto,
                    alignContent: .center
                )
            },
            footer: {
                Spacer(20)
            }
        )
    }

}
