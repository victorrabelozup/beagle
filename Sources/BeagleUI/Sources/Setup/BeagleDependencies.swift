//
//  BeagleLauncher.swift
//  BeagleUI
//
//  Created by Yan Dias on 09/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleDependenciesProtocol: RendererDependencies {

    var baseURL: URL? { get }
    var decoder: WidgetDecoding { get }
    var networkingDispatcher: URLRequestDispatching { get }
    var customWidgetsProvider: CustomWidgetsRendererProvider { get }
    var appBundle: Bundle { get }
    var applicationTheme: Theme { get }
    var validatorHandler: ValidatorHandler? { get }
    var deepLinkHandler: BeagleDeepLinkScreenManaging? { get }
    var customActionHandler: CustomActionHandler? { get }
}

open class BeagleDependencies: BeagleDependenciesProtocol {

    public private(set) var baseURL: URL?
    public private(set) var networkingDispatcher: URLRequestDispatching
    public private(set) var decoder: WidgetDecoding
    public private(set) var customWidgetsProvider: CustomWidgetsRendererProvider
    public private(set) var appBundle: Bundle
    public private(set) var applicationTheme: Theme
    public private(set) var validatorHandler: ValidatorHandler?
    public private(set) var deepLinkHandler: BeagleDeepLinkScreenManaging?
    public private(set) var customActionHandler: CustomActionHandler?
    public private(set) var flex: FlexViewConfiguratorProtocol
    public private(set) var rendererProvider: WidgetRendererProvider

    public var theme: Theme { return applicationTheme }
    
    public init(appName: String) {
        self.decoder = WidgetDecoder(namespace: appName)
        self.customWidgetsProvider = CustomWidgetsRendererProviding()
        self.appBundle = Bundle.main
        self.applicationTheme = AppTheme(styles: [:])
        self.networkingDispatcher = URLSessionDispatcher()
        self.flex = FlexViewConfigurator()
        self.rendererProvider = WidgetRendererProviding()
    }
    
    // MARK: - Builders
    @discardableResult
    public func appBundle(_ bundle: Bundle) -> BeagleDependencies {
        self.appBundle = bundle
        return self
    }
    
    @discardableResult
    public func networkingDispatcher(_ dispatcher: URLRequestDispatching) -> BeagleDependencies {
        self.networkingDispatcher = dispatcher
        return self
    }
    
    @discardableResult
    public func customWidgetsProvider(_ customWidgetsProvider: CustomWidgetsRendererProvider) -> BeagleDependencies {
        self.customWidgetsProvider = customWidgetsProvider
        return self
    }
    
    @discardableResult
    public func theme(_ theme: Theme) -> BeagleDependencies {
        self.applicationTheme = theme
        return self
    }
    
    @discardableResult
    public func deepLinkHandler(_ deepLinkHandler: BeagleDeepLinkScreenManaging) -> BeagleDependencies {
        self.deepLinkHandler = deepLinkHandler
        return self
    }
    
    @discardableResult
    public func validatorHandler(_ validatorHandler: ValidatorHandler) -> BeagleDependencies {
        self.validatorHandler = validatorHandler
        return self
    }
    
    @discardableResult
    public func actionHandler(_ actionHandler: CustomActionHandler) -> BeagleDependencies {
        self.customActionHandler = actionHandler
        return self
    }
    
    @discardableResult
    public func baseURL(_ baseURL: URL) -> BeagleDependencies {
        self.baseURL = baseURL
        return self
    }

    @discardableResult
    public func flex(_ flex: FlexViewConfiguratorProtocol) -> BeagleDependencies {
        self.flex = flex
        return self
    }

    @discardableResult
    public func rendererProvider(_ rendererProvider: WidgetRendererProvider) -> BeagleDependencies {
        self.rendererProvider = rendererProvider
        return self
    }
}
