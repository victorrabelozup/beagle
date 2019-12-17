//
//  BeagleLauncher.swift
//  BeagleUI
//
//  Created by Yan Dias on 09/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleDependenciesProtocol: RendererDependencies,
    DependencyActionExecutor,
    DependencyRemoteConnector,
    DependencyBaseURL,
    DependencyWidgetDecoding,
    DependencyNetworkDispatcher,
    DependencyCustomActionHandler,
    DependencyNavigation {

    var customWidgetsProvider: CustomWidgetsRendererProvider { get }
    var appBundle: Bundle { get }
    var deepLinkHandler: BeagleDeepLinkScreenManaging? { get }
}

open class BeagleDependencies: BeagleDependenciesProtocol {

    public var baseURL: URL?
    public var networkDispatcher: NetworkDispatcher
    public var decoder: WidgetDecoding
    public var customWidgetsProvider: CustomWidgetsRendererProvider
    public var appBundle: Bundle
    public var theme: Theme
    public var validatorProvider: ValidatorProvider?
    public var deepLinkHandler: BeagleDeepLinkScreenManaging?
    public var customActionHandler: CustomActionHandler?
    public var flex: FlexViewConfiguratorProtocol
    public var rendererProvider: WidgetRendererProvider
    public var actionExecutor: ActionExecutor
    public var remoteConnector: RemoteConnector
    public var navigation: BeagleNavigation

    private let resolver: InnerDependenciesResolver
    
    public init(appName: String) {
        let resolver = InnerDependenciesResolver()
        self.resolver = resolver

        self.decoder = WidgetDecoder(namespace: appName)
        self.networkDispatcher = URLSessionDispatcher()
        self.navigation = BeagleNavigator()
        self.customActionHandler = CustomActionHandling()

        self.customWidgetsProvider = CustomWidgetsRendererProviding()
        self.appBundle = Bundle.main
        self.theme = AppTheme(styles: [:])
        self.flex = FlexViewConfigurator()
        self.rendererProvider = WidgetRendererProviding()
        self.actionExecutor = ActionExecuting(dependencies: resolver)
        self.remoteConnector = RemoteConnecting(dependencies: resolver)

        self.resolver.container = { [unowned self] in self }
    }

    // MARK: - Builders
    @discardableResult
    public func appBundle(_ bundle: Bundle) -> BeagleDependencies {
        self.appBundle = bundle
        return self
    }
    
    @discardableResult
    public func networkingDispatcher(_ dispatcher: NetworkDispatcher) -> BeagleDependencies {
        self.networkDispatcher = dispatcher
        return self
    }
    
    @discardableResult
    public func customWidgetsProvider(_ customWidgetsProvider: CustomWidgetsRendererProvider) -> BeagleDependencies {
        self.customWidgetsProvider = customWidgetsProvider
        return self
    }
    
    @discardableResult
    public func theme(_ theme: Theme) -> BeagleDependencies {
        self.theme = theme
        return self
    }
    
    @discardableResult
    public func deepLinkHandler(_ deepLinkHandler: BeagleDeepLinkScreenManaging) -> BeagleDependencies {
        self.deepLinkHandler = deepLinkHandler
        return self
    }
    
    @discardableResult
    public func validatorProvider(_ validatorProvider: ValidatorProvider) -> BeagleDependencies {
        self.validatorProvider = validatorProvider
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

    @discardableResult
    public func actionExecutor(_ actionExecutor: ActionExecutor) -> BeagleDependencies {
        self.actionExecutor = actionExecutor
        return self
    }
}

/// This class helps solving the problem of using the same dependency container to resolve
/// dependencies within dependencies.
/// The problem happened because we needed to pass `self` as dependency before `init` has concluded.
/// - Example: see where `resolver` is being used in the `BeagleDependencies` `init`.
private class InnerDependenciesResolver: RemoteConnecting.Dependencies,
    ActionExecuting.Dependencies {

    var container: () -> BeagleDependenciesProtocol = {
        fatalError("You should set this closure to get the dependencies container")
    }

    var baseURL: URL? { container().baseURL }
    var decoder: WidgetDecoding { container().decoder }
    var networkDispatcher: NetworkDispatcher { container().networkDispatcher }
    var navigation: BeagleNavigation { container().navigation }
    var customActionHandler: CustomActionHandler? { container().customActionHandler }
}
