/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleSetupTests: XCTestCase {

    func testDefaultDependencies() {
        let dependencies = BeagleDependencies()
        assertSnapshot(matching: dependencies, as: .dump)
    }

    func testChangedDependencies() {
        let dep = BeagleDependencies()
        dep.appBundle = Bundle.main
        dep.deepLinkHandler = DeepLinkHandlerDummy()
        dep.theme = AppThemeDummy()
        dep.validatorProvider = ValidatorProviding()
        dep.customActionHandler = CustomActionHandlerDummy()
        if let url = URL(string: "www.test.com") {
            dep.urlBuilder.baseUrl = url
        }
        dep.networkClient = NetworkClientDummy()
        dep.flex = { _ in return FlexViewConfiguratorDummy() }
        dep.decoder = ComponentDecodingDummy()
        dep.cacheManager = CacheManager(maximumScreensCapacity: 10)
        dep.logger = BeagleLoggerDumb()
        
        assertSnapshot(matching: dep, as: .dump)
    }

    func test_ifChangingDependency_othersShouldUseNewInstance() {
        let dependencies = BeagleDependencies()

        let actionSpy = CustomActionHandlerSpy()
        dependencies.customActionHandler = actionSpy

        let dummyAction = CustomAction(name: "", data: [:])

        dependencies.actionExecutor.doAction(
            dummyAction,
            sender: self,
            context: BeagleContextDummy()
        )

        XCTAssert(actionSpy.actionsHandledCount == 1)
    }
}

// MARK: - Testing Helpers

final class DeepLinkHandlerDummy: DeepLinkScreenManaging {
    func getNativeScreen(with path: String, data: [String: String]?) throws -> UIViewController {
        return UIViewController()
    }
}

final class ComponentDecodingDummy: ComponentDecoding {
    func register<T>(_ type: T.Type, for typeName: String) where T: ServerDrivenComponent {}
    func decodableType(forType type: String) -> Decodable.Type? { return nil }
    func decodeComponent(from data: Data) throws -> ServerDrivenComponent { return ComponentDummy() }
    func decodeAction(from data: Data) throws -> Action { return ActionDummy() }
}

struct ComponentDummy: ServerDrivenComponent, Equatable, CustomStringConvertible {
    
    private let uuid = UUID()
    
    var description: String {
        return "ComponentDummy()"
    }
    
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return DummyView()
    }
}

final class DummyView: UIView {}

struct ActionDummy: Action, Equatable {}

struct BeagleScreenDependencies: BeagleScreenViewModel.Dependencies {
    
    var analytics: Analytics?
    var actionExecutor: ActionExecutor
    var flex: FlexViewConfiguratorProtocol
    var network: Network
    var theme: Theme
    var validatorProvider: ValidatorProvider?
    var preFetchHelper: BeaglePrefetchHelping
    var appBundle: Bundle
    var cacheManager: CacheManagerProtocol
    var decoder: ComponentDecoding
    var logger: BeagleLoggerType

    init(
        actionExecutor: ActionExecutor = ActionExecutorDummy(),
        flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy(),
        network: Network = NetworkStub(),
        theme: Theme = AppThemeDummy(),
        validatorProvider: ValidatorProvider = ValidatorProviding(),
        preFetchHelper: BeaglePrefetchHelping = BeaglePreFetchHelper(),
        appBundle: Bundle = Bundle(for: ImageTests.self),
        cacheManager: CacheManagerProtocol = CacheManager(maximumScreensCapacity: 30),
        decoder: ComponentDecoding = ComponentDecodingDummy(),
        logger: BeagleLoggerType = BeagleLoggerDumb(),
        analytics: Analytics = AnalyticsExecutorSpy()
    ) {
        self.actionExecutor = actionExecutor
        self.flex = flex
        self.network = network
        self.theme = theme
        self.validatorProvider = validatorProvider
        self.preFetchHelper = preFetchHelper
        self.appBundle = appBundle
        self.cacheManager = cacheManager
        self.decoder = decoder
        self.logger = logger
        self.analytics = analytics
    }
}

class NetworkClientDummy: NetworkClient {
    func executeRequest(_ request: Request, completion: @escaping RequestCompletion) -> RequestToken? {
        return nil
    }
}

final class AppThemeDummy: Theme {
    func applyStyle<T>(for view: T, withId id: String) where T: UIView {

    }
}
