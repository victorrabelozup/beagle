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
        
        guard let url = URL(string: "http://localhost:8000/home.json") else {
            fatalError()
        }
        
        Beagle.registerCustomWidget(.init(entity: .init(typeName: "switch", type: SwitchEntity.self), view: .init(widgetType: Switch.self, viewRenderer: SwitchRenderer.self)))
        let rootViewController = BeagleScreenViewController(screenType: .remote(url))
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

//struct TextScreen: Screen {
//    var content: Widget {
//        ScrollView {
//            Switch(isOn: false)
//        }
//    }
//}

struct Switch: NativeWidget {
    let isOn: Bool
}

struct SwitchEntity: WidgetConvertibleEntity {
    func mapToWidget() throws -> Widget {
        return Switch(isOn: isOn)
    }
    
    let isOn: Bool
}

class SwitchRenderer: WidgetViewRenderer<Switch> {
    override func buildView(context: BeagleContext) -> UIView {
        let view = UISwitch()
        view.isOn = widget.isOn
        
        return view
    }
}
