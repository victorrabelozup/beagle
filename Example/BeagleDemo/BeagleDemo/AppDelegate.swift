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
        deepLinkHandler["lazycomponent"] = LazyComponentScreen.self
        deepLinkHandler["pageview"] = PageViewScreen.self
        deepLinkHandler["tabview"] = TabViewScreen.self
        deepLinkHandler["form"] = FormScreen.self
        deepLinkHandler["customComponent"] = CustomComponentScreen.self
        deepLinkHandler["screen-deep-link"] = ScreenDeepLink.self
        deepLinkHandler["listview"] = ListViewScreen.self

        let validator = ValidatorProviding()
        validator[FormScreen.textValidatorName] = FormScreen.textValidator
        
        let dependencies = BeagleDependencies()
        dependencies.theme = Style.theme
        dependencies.urlBuilder = UrlBuilder(baseUrl: URL(string: "http://localhost:8080/"))
        dependencies.deepLinkHandler = deepLinkHandler
        dependencies.validatorProvider = validator
        Beagle.dependencies = dependencies
        
        registerCustomComponents()
        
        let rootViewController = MainScreen().screenController()
        window?.rootViewController = rootViewController
        
        return true
    }
    
    private func registerCustomComponents() {
        Beagle.registerCustomComponent("DSCollection", componentType: DSCollection.self, entityType: DSCollectionEntity.self)
        Beagle.registerCustomComponent("SampleTextField", componentType: DemoTextField.self, entityType: DemoTextFieldEntity.self)
    }
}
