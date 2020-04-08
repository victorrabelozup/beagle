/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import BeagleUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let deepLinkHandler = DeeplinkScreenManager.shared
        deepLinkHandler[.LAZY_COMPONENTS_ENDPOINT] = LazyComponentScreen.self
        deepLinkHandler[.PAGE_VIEW_ENDPOINT] = PageViewScreen.self
        deepLinkHandler[.TAB_VIEW_ENDPOINT] = TabViewScreen.self
        deepLinkHandler[.FORM_ENDPOINT] = FormScreen.self
        deepLinkHandler[.CUSTOM_COMPONENT_ENDPOINT] = CustomComponentScreen.self
        deepLinkHandler[.DEEPLINK_ENDPOINT] = ScreenDeepLink.self
        deepLinkHandler[.LIST_VIEW_ENDPOINT] = ListViewScreen.self
        deepLinkHandler[.WEB_VIEW_ENDPOINT] = WebViewScreen.self

        let validator = ValidatorProviding()
        validator[FormScreen.textValidatorName] = FormScreen.textValidator
        
        let dependencies = BeagleDependencies()
        dependencies.theme = Style.theme
        dependencies.urlBuilder = UrlBuilder(baseUrl: URL(string: .BASE_URL))
        dependencies.deepLinkHandler = deepLinkHandler
        dependencies.validatorProvider = validator
        dependencies.analytics = AnalyticsMock()
        Beagle.dependencies = dependencies
        
        registerCustomComponents()
        
        let rootViewController = MainScreen().screenController()
        window?.rootViewController = rootViewController
        
        return true
    }
    
    private func registerCustomComponents() {
        Beagle.registerCustomComponent("DSCollection", componentType: DSCollection.self)
        Beagle.registerCustomComponent("SampleTextField", componentType: DemoTextField.self)
    }
}
