//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleSetupTests: XCTestCase {

    func testDefaultDependencies() {
        let dependencies = BeagleDependencies(appName: "DEFAULT")
        assertSnapshot(matching: dependencies, as: .dump)
    }

    func testChangedDependencies() {
        let dep = BeagleDependencies(appName: "Beagle")
        dep.appBundle = Bundle.main
        dep.deepLinkHandler = DeepLinkHandlerDummy()
        dep.theme = AppThemeDummy()
        dep.validatorProvider = ValidatorProviding()
        dep.customActionHandler = CustomActionHandlerDummy()
        dep.baseURL = URL(string: "www.test.com")!
        dep.networkDispatcher = URLRequestDispatchingDummy()
        dep.customWidgetsProvider = CustomWidgetsRendererProviderDummy()
        dep.flex = FlexViewConfiguratorDummy()
        dep.rendererProvider = RendererProviderDummy()

        assertSnapshot(matching: dep, as: .dump)
    }

    func test_ifChangingDependency_othersShouldUseNewInstance() {
        let dependencies = BeagleDependencies(appName: "TEST")

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

final class DeepLinkHandlerDummy: BeagleDeepLinkScreenManaging {
    func getNaviteScreen(with path: String, data: [String : String]?) throws -> UIViewController {
        return UIViewController()
    }
}

final class WidgetDecodingDummy: WidgetDecoding {
    func register<T>(_ type: T.Type, for typeName: String) where T : WidgetEntity {}
    func decodeWidget(from data: Data) throws -> Widget { return WidgetDummy() }
    func decodeAction(from data: Data) throws -> Action { return ActionDummy() }
}

final class ViewRendererDummy: ViewRendering<WidgetDummy> {
    override func buildView(context: BeagleContext) -> UIView { return UIView() }
}

final class CustomWidgetsRendererProviderDummy: CustomWidgetsRendererProvider {
    func registerRenderer<W>(_ rendererType: ViewRendering<W>.Type, for widgetType: W.Type) where W : Widget {}
    func buildRenderer(for widget: Widget, dependencies: ViewRenderer.Dependencies) throws -> ViewRenderer {
        return try ViewRendererDummy(widget: widget, dependencies: Beagle.dependencies)
    }
}

struct WidgetDummyEntity: WidgetConvertibleEntity {
    func mapToWidget() throws -> Widget {
        return WidgetDummy()
    }
}

class URLRequestDispatchingDummy: NetworkDispatcher {
    func execute(on queue: DispatchQueue, request: URLRequestProtocol, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        return nil
    }
}

final class AppThemeDummy: Theme {
    func applyStyle<T>(for view: T, withId id: String) where T : UIView {

    }
}
