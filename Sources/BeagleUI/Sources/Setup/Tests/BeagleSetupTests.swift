//
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
            dep.baseURL = url
        }
        dep.networkClient = NetworkClientDummy()
        dep.flex = FlexViewConfiguratorDummy()
        dep.decoder = ComponentDecodingDummy()
        dep.cacheManager = CacheManager(maximumScreensCapacity: 10)
        dep.accessibility = AccessibilityConfigurator()
        
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
    func register<T>(_ type: T.Type, for typeName: String) where T: ComponentEntity {}
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

class BeagleContextDummy: BeagleContext {
    
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {}
    func register(form: Form, formView: UIView, submitView: UIView, validatorHandler: ValidatorProvider?) {}
    func register(formSubmitEnabledWidget: Widget?, formSubmitDisabledWidget: Widget?) {}
    func lazyLoad(url: String, initialState: UIView) {}
    func doAction(_ action: Action, sender: Any) {}
}

struct RendererDependenciesContainer: RenderableDependencies {
    var network: Network
    var flex: FlexViewConfiguratorProtocol
    var theme: Theme
    var validatorProvider: ValidatorProvider?
    var preFetchHelper: BeaglePrefetchHelping
    var appBundle: Bundle
    var accessibility: AccessibilityConfiguratorProtocol
    var cacheManager: CacheManagerProtocol

    init(
        network: Network = NetworkDummy(),
        flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy(),
        theme: Theme = AppThemeDummy(),
        validatorProvider: ValidatorProvider? = ValidatorProviding(),
        preFetchHelper: BeaglePrefetchHelping = BeaglePreFetchHelper(),
        appBundle: Bundle = Bundle(for: ImageTests.self),
        accessibility: AccessibilityConfiguratorProtocol = AccessibilityConfigurator(),
        cacheManager: CacheManagerProtocol = CacheManager(maximumScreensCapacity: 30)
    ) {
        self.network = network
        self.flex = flex
        self.theme = theme
        self.validatorProvider = validatorProvider
        self.preFetchHelper = preFetchHelper
        self.appBundle = appBundle
        self.accessibility = accessibility
        self.cacheManager = cacheManager
    }
}

struct ComponentDummyEntity: ComponentConvertibleEntity {
    func mapToComponent() throws -> ServerDrivenComponent {
        return ComponentDummy()
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
