/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public protocol BeagleDependenciesProtocol: DependencyActionExecutor,
    DependencyAnalyticsExecutor,
    DependencyUrlBuilder,
    DependencyComponentDecoding,
    DependencyNetworkClient,
    DependencyDeepLinkScreenManaging,
    DependencyCustomActionHandler,
    DependencyNavigation,
    DependencyViewConfigurator,
    DependencyFlexConfigurator,
    RenderableDependencies {
}

open class BeagleDependencies: BeagleDependenciesProtocol {
    
    public var urlBuilder: UrlBuilderProtocol
    public var networkClient: NetworkClient
    public var decoder: ComponentDecoding
    public var appBundle: Bundle
    public var theme: Theme
    public var validatorProvider: ValidatorProvider?
    public var deepLinkHandler: DeepLinkScreenManaging?
    public var customActionHandler: CustomActionHandler?
    public var actionExecutor: ActionExecutor
    public var analytics: Analytics?
    public var network: Network
    public var navigation: BeagleNavigation
    public var preFetchHelper: BeaglePrefetchHelping
    public var cacheManager: CacheManagerProtocol
    public var logger: BeagleLoggerType

    public var flex: (UIView) -> FlexViewConfiguratorProtocol = {
        return FlexViewConfigurator(view: $0)
    }

    public var viewConfigurator: (UIView) -> ViewConfiguratorProtocol = {
        return ViewConfigurator(view: $0)
    }

    private let resolver: InnerDependenciesResolver

    public init() {
        let resolver = InnerDependenciesResolver()
        self.resolver = resolver

        self.urlBuilder = UrlBuilder()
        self.decoder = ComponentDecoder()
        self.preFetchHelper = BeaglePreFetchHelper()
        self.customActionHandler = nil
        self.appBundle = Bundle.main
        self.theme = AppTheme(styles: [:])

        self.networkClient = NetworkClientDefault(dependencies: resolver)
        self.navigation = BeagleNavigator(dependencies: resolver)
        self.actionExecutor = ActionExecuting(dependencies: resolver)
        self.network = NetworkDefault(dependencies: resolver)
        self.cacheManager = CacheManager(maximumScreensCapacity: 30)
        self.logger = BeagleLogger()

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
    DependencyUrlBuilder,
    DependencyLogger {

    var container: () -> BeagleDependenciesProtocol = {
        fatalError("You should set this closure to get the dependencies container")
    }

    var urlBuilder: UrlBuilderProtocol { return container().urlBuilder }
    var decoder: ComponentDecoding { return container().decoder }
    var networkClient: NetworkClient { return container().networkClient }
    var navigation: BeagleNavigation { return container().navigation }
    var deepLinkHandler: DeepLinkScreenManaging? { return container().deepLinkHandler }
    var customActionHandler: CustomActionHandler? { return container().customActionHandler }
    var logger: BeagleLoggerType { return container().logger }
}
