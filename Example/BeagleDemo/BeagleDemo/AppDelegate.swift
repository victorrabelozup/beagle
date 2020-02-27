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

        let validator = ValidatorProviding()
        validator[FormScreen.textValidatorName] = FormScreen.textValidator
        
        let dependencies = BeagleDependencies()
        dependencies.deepLinkHandler = deepLinkHandler
        dependencies.theme = Style.theme
        dependencies.validatorProvider = validator
        Beagle.dependencies = dependencies
        
        Beagle.registerCustomComponent("DSCollection", componentType: DSCollection.self, entityType: DSCollectionEntity.self)
        
        let rootViewController = MainScreen().screenController()
        window?.rootViewController = rootViewController
        
        return true
    }
    
}

public struct Style {
    
    static var theme: AppTheme {
        return AppTheme(
            styles: ["form-button": Style.formButton]
        )
    }
    
    static func formButton() -> (UIButton?) -> Void {
        return {
            $0?.layer.cornerRadius = 4
            $0?.setTitleColor(.white, for: .normal)
            $0?.backgroundColor = $0?.isEnabled ?? false ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            $0?.alpha = $0?.isHighlighted ?? false ? 0.7 : 1
        }
    }
}

