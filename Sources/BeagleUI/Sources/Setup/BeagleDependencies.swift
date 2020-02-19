//
//  Copyright © 09/12/19 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleDependenciesProtocol: DependencyActionExecutor,
    DependencyBaseURL,
    DependencyComponentDecoding,
    DependencyNetworkClient,
    DependencyDeepLinkScreenManaging,
    DependencyCustomActionHandler,
    DependencyNavigation,
    RenderableDependencies {
}

open class BeagleDependencies: BeagleDependenciesProtocol {
    
    public var baseURL: URL?
    public var networkClient: NetworkClient
    public var decoder: ComponentDecoding
    public var appBundle: Bundle
    public var theme: Theme
    public var validatorProvider: ValidatorProvider?
    public var deepLinkHandler: DeepLinkScreenManaging?
    public var customActionHandler: CustomActionHandler?
    public var flex: FlexViewConfiguratorProtocol
    public var actionExecutor: ActionExecutor
    public var network: Network
    public var navigation: BeagleNavigation
    public var preFetchHelper: BeaglePrefetchHelping
    public var accessibility: AccessibilityConfiguratorProtocol
    
    public var cacheManager: CacheManagerProtocol

    private let resolver: InnerDependenciesResolver
    
    public init() {
        let resolver = InnerDependenciesResolver()
        self.resolver = resolver

        self.decoder = ComponentDecoder()
        self.preFetchHelper = BeaglePreFetchHelper()
        self.customActionHandler = nil
        self.appBundle = Bundle.main
        self.theme = AppTheme(styles: [:])
        self.flex = FlexViewConfigurator(view: UIView())

        self.networkClient = NetworkClientDefault(dependencies: resolver)
        self.navigation = BeagleNavigator(dependencies: resolver)
        self.actionExecutor = ActionExecuting(dependencies: resolver)
        self.network = NetworkDefault(dependencies: resolver)
        self.accessibility = AccessibilityConfigurator()
        self.cacheManager = CacheManager(maximumScreensCapacity: 30)
        
        self.resolver.container = { [unowned self] in self }
    }
}

/// This class helps solving the problem of using the same dependency container to resolve
/// dependencies within dependencies.
/// The problem happened because we needed to pass `self` as dependency before `init` has concluded.
/// - Example: see where `resolver` is being used in the `BeagleDependencies` `init`.
private class InnerDependenciesResolver: NetworkDefault.Dependencies,
    ActionExecuting.Dependencies,
    DependencyDeepLinkScreenManaging,
    DependencyBaseURL {

    var container: () -> BeagleDependenciesProtocol = {
        fatalError("You should set this closure to get the dependencies container")
    }

    var baseURL: URL? { return container().baseURL }
    var decoder: ComponentDecoding { return container().decoder }
    var networkClient: NetworkClient { return container().networkClient }
    var navigation: BeagleNavigation { return container().navigation }
    var deepLinkHandler: DeepLinkScreenManaging? { return container().deepLinkHandler }
    var customActionHandler: CustomActionHandler? { return container().customActionHandler }
}
