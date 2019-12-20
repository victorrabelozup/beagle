//
//  BeagleLauncher.swift
//  BeagleUI
//
//  Created by Yan Dias on 09/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleDependenciesProtocol: DependencyFlexViewConfigurator,
    DependencyRendererProvider,
    DependencyTheme,
    DependencyValidatorProvider,
    DependencyActionExecutor,
    DependencyRemoteConnector,
    DependencyBaseURL,
    DependencyWidgetDecoding,
    DependencyNetworkDispatcher,
    DependencyCustomActionHandler,
    DependencyNavigation,
    DependencyPreFetching {

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
    public var rendererProvider: RendererProvider
    public var actionExecutor: ActionExecutor
    public var remoteConnector: RemoteConnector
    public var navigation: BeagleNavigation
    public var preFetchHelper: BeaglePrefetchHelping

    private let resolver: InnerDependenciesResolver
    
    public init(appName: String) {
        let resolver = InnerDependenciesResolver()
        self.resolver = resolver

        self.decoder = WidgetDecoder(namespace: appName)
        self.networkDispatcher = URLSessionDispatcher()
        self.preFetchHelper = BeaglePreFetchHelper()
        self.customActionHandler = CustomActionHandling()
        self.customWidgetsProvider = CustomWidgetsRendererProviding()
        self.appBundle = Bundle.main
        self.theme = AppTheme(styles: [:])
        self.flex = FlexViewConfigurator()
        self.rendererProvider = RendererProviding()
        
        self.navigation = BeagleNavigator(dependencies: resolver)
        self.actionExecutor = ActionExecuting(dependencies: resolver)
        self.remoteConnector = RemoteConnecting(dependencies: resolver)
        
        self.resolver.container = { [unowned self] in self }
    }
}

/// This class helps solving the problem of using the same dependency container to resolve
/// dependencies within dependencies.
/// The problem happened because we needed to pass `self` as dependency before `init` has concluded.
/// - Example: see where `resolver` is being used in the `BeagleDependencies` `init`.
private class InnerDependenciesResolver: RemoteConnecting.Dependencies,
    ActionExecuting.Dependencies,
    DependencyPreFetching {

    var container: () -> BeagleDependenciesProtocol = {
        fatalError("You should set this closure to get the dependencies container")
    }

    var baseURL: URL? { container().baseURL }
    var decoder: WidgetDecoding { container().decoder }
    var networkDispatcher: NetworkDispatcher { container().networkDispatcher }
    var navigation: BeagleNavigation { container().navigation }
    var preFetchHelper: BeaglePrefetchHelping { container().preFetchHelper }
    var customActionHandler: CustomActionHandler? { container().customActionHandler }
    
}
