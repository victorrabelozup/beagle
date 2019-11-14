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
        
        let theme = AppTheme(styles: ["h1": BeagleStyle.h1Style, "grayButton": BeagleStyle.grayButton])
        Beagle.start(appName: "BeagleDemo", applicationTheme: theme)
        
        let rootViewController = BeagleScreenViewController(screenType: .declarative(TextScreen()))
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

struct TextScreen: Screen {
    var content: Widget {
        Button(text: "test", style: "grayButton")
    }
}

extension BeagleStyle {
    static func h1Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 10), color: .black)
    }

    static func h2Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 14), color: .black)
    }

    static func h3Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 16), color: .black)
    }

    static func grayButton() -> (UIButton?) -> Void {
        backgroundColor(withColor: .gray)
            <> {
                $0?.titleLabel |> h1Style()
        }
    }
}
