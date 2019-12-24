//
//  Copyright © 2019 Zup IT. All rights reserved.
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
        deepLinkHandler["tabview"] = TabViewScreen.self

        let dependencies = BeagleDependencies(appName: "BeagleDemo")
        dependencies.deepLinkHandler = deepLinkHandler
        Beagle.dependencies = dependencies
        
        let rootViewController = BeagleScreenViewController(screenType: .declarative(MainScreen().widget))
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        return true
    }
    
}
