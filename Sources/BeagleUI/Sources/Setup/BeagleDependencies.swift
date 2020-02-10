//
//  Copyright © 09/12/19 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleDependenciesProtocol: DependencyFlexViewConfigurator,
    DependencyTheme,
    DependencyValidatorProvider,
    DependencyActionExecutor,
    DependencyNetwork,
    DependencyBaseURL,
    DependencyWidgetDecoding,
    DependencyNetworkClient,
    DependencyCustomActionHandler,
    DependencyNavigation,
    DependencyPreFetching,
    DependencyAppBundle {

    var deepLinkHandler: BeagleDeepLinkScreenManaging? { get }
}

open class BeagleDependencies: BeagleDependenciesProtocol {

    public var baseURL: URL?
    public var networkClient: NetworkClient
    public var decoder: WidgetDecoding
    public var appBundle: Bundle
    public var theme: Theme
    public var validatorProvider: ValidatorProvider?
    public var deepLinkHandler: BeagleDeepLinkScreenManaging?
    public var customActionHandler: CustomActionHandler?
    public var flex: FlexViewConfiguratorProtocol
    public var actionExecutor: ActionExecutor
    public var network: Network
    public var navigation: BeagleNavigation
    public var preFetchHelper: BeaglePrefetchHelping

    private let resolver: InnerDependenciesResolver
    
    public init(appName: String = "Beagle") {
        let resolver = InnerDependenciesResolver()
        self.resolver = resolver

        self.decoder = WidgetDecoder(namespace: appName)
        self.preFetchHelper = BeaglePreFetchHelper()
        self.customActionHandler = CustomActionHandling()
        self.appBundle = Bundle.main
        self.theme = AppTheme(styles: [:])
        self.flex = FlexViewConfigurator()

        self.networkClient = NetworkClientDefault(dependencies: resolver)
        self.navigation = BeagleNavigator(dependencies: resolver)
        self.actionExecutor = ActionExecuting(dependencies: resolver)
        self.network = NetworkDefault(dependencies: resolver)
        
        self.resolver.container = { [unowned self] in self }
    }
}

/// This class helps solving the problem of using the same dependency container to resolve
/// dependencies within dependencies.
/// The problem happened because we needed to pass `self` as dependency before `init` has concluded.
/// - Example: see where `resolver` is being used in the `BeagleDependencies` `init`.
private class InnerDependenciesResolver: NetworkDefault.Dependencies,
    ActionExecuting.Dependencies,
    DependencyPreFetching,
    DependencyBaseURL {

    var container: () -> BeagleDependenciesProtocol = {
        fatalError("You should set this closure to get the dependencies container")
    }

    var baseURL: URL? { return container().baseURL }
    var decoder: WidgetDecoding { return container().decoder }
    var networkClient: NetworkClient { return container().networkClient }
    var navigation: BeagleNavigation { return container().navigation }
    var preFetchHelper: BeaglePrefetchHelping { return container().preFetchHelper }
    var customActionHandler: CustomActionHandler? { return container().customActionHandler }
}
