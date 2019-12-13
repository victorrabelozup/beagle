//
//  BeagleSetupTests.swift
//  BeagleFrameworkTests
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleSetupTests: XCTestCase {

    func testDefaultDependencies() {
        let dependencies = BeagleDependencies(appName: "DEFAULT")
        assertSnapshot(matching: dependencies, as: .dump)
    }

    func test_start_shouldStartTheEnviromentWithRightBundle() {
        let dependencies = BeagleDependencies(appName: "Beagle")
            .appBundle(Bundle.main)
            .deepLinkHandler(DeepLinkHandlerDummy())
            .theme(AppThemeDummy())
            .validatorHandler(ValidatorHandling())
            .actionHandler(CustomActionHandlerDummy())
            .baseURL(URL(string: "www.test.com")!)
            .networkingDispatcher(URLRequestDispatchingDummy())
            .customWidgetsProvider(CustomWidgetsRendererProviderDummy())
            .flex(FlexViewConfiguratorDummy())
            .rendererProvider(WidgetRendererProviderDummy())

        // Then
        assertSnapshot(matching: dependencies, as: .dump)
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

final class WidgetViewRendererDummy: WidgetViewRenderer<WidgetDummy> {
    override func buildView(context: BeagleContext) -> UIView { return UIView() }
}

final class CustomWidgetsRendererProviderDummy: CustomWidgetsRendererProvider {
    func registerRenderer<W>(_ rendererType: WidgetViewRenderer<W>.Type, for widgetType: W.Type) where W : Widget {}
    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) throws -> WidgetViewRendererProtocol {
        return try WidgetViewRendererDummy(widget: widget, dependencies: Beagle.dependencies)
    }
}

struct WidgetDummyEntity: WidgetConvertibleEntity {
    func mapToWidget() throws -> Widget {
        return WidgetDummy()
    }
}

class URLRequestDispatchingDummy: URLRequestDispatching {
    func execute(on queue: DispatchQueue, request: URLRequestProtocol, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        return nil
    }
}

final class AppThemeDummy: Theme {
    func applyStyle<T>(for view: T, withId id: String) where T : UIView {

    }
}
