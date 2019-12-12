//
//  BeagleSetupTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 15/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI
import Networking

final class BeagleSetupTests: XCTestCase {

    func test_start_shouldStartTheEnvironment() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy

        // When
        Beagle.start()

        // Then
        XCTAssertTrue(environmentSpy.initializeCalled)
    }

    func test_start_shouldThrowFatalErrorIfCalledTwice() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        Beagle.start()

        // When / Then
        expectFatalError(expectedMessage: "Beagle.start should be called only one time!") {
            Beagle.start()
        }
    }

    func test_start_shouldStartTheEnviromentWithRightBundle() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let bundle = Bundle()

        // When
        Beagle.start(appName: "appName", appBundle: bundle)

        // Then
        XCTAssertNotNil(environmentSpy.bundlePassed, "Expected a bundle to be passed.")
        XCTAssertEqual(bundle, environmentSpy.bundlePassed)
    }

    func test_registerCustomWidgets_shouldCallRegisterWidgetsOnEnvironment_passingOnlyOneWidget() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        Beagle.start()
        let customWidgetToRegister = WidgetRegisterItem(
            entity: .init(
                typeName: "WidgetDummy",
                type: WidgetDummyEntity.self
            ),
            view: .init(
                widgetType: WidgetDummy.self,
                viewRenderer: WidgetViewRendererDummy.self
            )
        )

        // When
        Beagle.registerCustomWidget(customWidgetToRegister)

        // Then
        guard let sharedInstance = environmentSpy._shared else {
            XCTFail("Could not find sharedInstance.")
            return
        }

        XCTAssertTrue(sharedInstance.registerCustomWidgetsCalled, "`registerCustomWidgets` should have been called on the environment.")
        XCTAssertNotNil(sharedInstance.itemPassed, "An item should have been passed.")
    }

    func test_start_shouldStartTheEnviromentWithDeepLinkHandlerConfigured() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let deepLinkHandler = DeepLinkHandlerDummy()

        // When
        Beagle.start(deepLinkHandler: deepLinkHandler)

        //Then
        XCTAssertTrue(environmentSpy.initializeCalled)
        XCTAssertNotNil(environmentSpy.deepLinkHandlerPassed)
        XCTAssertTrue(deepLinkHandler === environmentSpy.deepLinkHandlerPassed as? DeepLinkHandlerDummy)
    }

    func test_start_shouldStartTheEnviromentWithAppThemeConfigured() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let theme = AppThemeDummy()

        // When
        Beagle.start(applicationTheme: theme)

        // Then
        XCTAssertTrue(environmentSpy.initializeCalled)
        XCTAssertNotNil(environmentSpy.applicationThemePassed)
        XCTAssertTrue(theme === environmentSpy.applicationThemePassed as? AppThemeDummy)
    }

    func test_configureTheme_shouldCallConfigureTheme_passingTheme() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let theme = AppThemeDummy()

        // When
        Beagle.start()
        Beagle.configureTheme(theme)

        // Then
        guard let sharedInstance = environmentSpy._shared else {
            XCTFail("Could not find sharedInstance.")
            return
        }
        XCTAssertTrue(sharedInstance.configureThemeCalled)
        XCTAssertNotNil(sharedInstance.themePassed)
        XCTAssertTrue(theme === sharedInstance.themePassed as? AppThemeDummy)
    }
    
    func test_configureValidatorHandler_shouldSetValidatorHandler() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let validatorHandler = ValidatorHandling()
        
        // When
        Beagle.start()
        Beagle.configureValidatorHandler(validatorHandler)
        
        // Then
        guard let sharedInstance = environmentSpy._shared else {
            XCTFail("Could not find sharedInstance.")
            return
        }
        XCTAssertTrue(sharedInstance.configureValidatorHandlerCalled)
        XCTAssertNotNil(sharedInstance.validatorHandlerPassed)
        XCTAssertTrue(validatorHandler === sharedInstance.validatorHandlerPassed as? ValidatorHandling)
    }
    
    func test_configureCustomActionHandler_shouldSetCustomActionHandler() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.didCallStart = false
        Beagle.environment = environmentSpy
        let customActionHandler = CustomActionHandlerDummy()
        
        // When
        Beagle.start()
        Beagle.configureCustomActionHandler(customActionHandler)
        
        // Then
        guard let sharedInstance = environmentSpy._shared else {
            XCTFail("Could not find sharedInstance.")
            return
        }
        XCTAssertTrue(sharedInstance.configureCustomActionHandlerCalled)
        XCTAssertNotNil(sharedInstance.customActionHandlerPassed)
        XCTAssertTrue(customActionHandler === sharedInstance.customActionHandlerPassed as? CustomActionHandlerDummy)
    }
}

// MARK: - Testing Helpers

final class BeagleEnvironmentSpy: BeagleEnvironmentProtocol {
    
    var baseURL: URL? {
        return nil
    }
    
    private(set) var deepLinkHandlerCalled = false
    var deepLinkHandler: BeagleDeepLinkScreenManaging? {
        deepLinkHandlerCalled = true
        return DeepLinkHandlerDummy()
    }

    private(set) var appBundleCalled = false
    var appBundle: Bundle {
        appBundleCalled = true
        return Bundle()
    }

    private(set) var decoderCalled = false
    var decoder: WidgetDecoding {
        decoderCalled = true
        return WidgetDecodingDummy()
    }

    private(set) var networkingDispatcherCalled = false
    var networkingDispatcher: URLRequestDispatching {
        networkingDispatcherCalled = true
        return URLRequestDispatchingDummy()
    }

    var customWidgetsProvider: CustomWidgetsRendererProvider { CustomWidgetsRendererProviderDummy() }

    private(set) var applicationThemeCalled = false
    var applicationTheme: Theme {
        applicationThemeCalled = true
        return AppThemeDummy()
    }
    
    var validatorHandler: ValidatorHandler?
    
    var customActionHandler: CustomActionHandler?

    var flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy()
    var rendererProvider: WidgetRendererProvider = WidgetRendererProviding()
    var theme: Theme = AppThemeDummy()

    private(set) static var _shared: BeagleEnvironmentSpy?
    static var shared: BeagleEnvironmentProtocol {
        return _shared!
    }

    init() {}

    static private(set) var initializeCalled = false
    static private(set) var bundlePassed: Bundle?
    static private(set) var applicationThemePassed: Theme?
    static private(set) var deepLinkHandlerPassed: BeagleDeepLinkScreenManaging?
    static private(set) var validatorHandlerPassed: ValidatorHandler?
    static private(set) var customActionHandlerPassed: CustomActionHandler?
    static func initialize(
        appName: String,
        baseURL: URL?,
        decoder: WidgetDecoding,
        networkingDispatcher: URLRequestDispatching,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProvider,
        appBundle: Bundle,
        deepLinkHandler: BeagleDeepLinkScreenManaging?,
        applicationTheme: Theme,
        validatorHandler: ValidatorHandler?,
        customActionHandler: CustomActionHandler?
    ) {
        _shared = BeagleEnvironmentSpy()
        initializeCalled = true
        bundlePassed = appBundle
        applicationThemePassed = applicationTheme
        deepLinkHandlerPassed = deepLinkHandler
        validatorHandlerPassed = validatorHandler
        customActionHandlerPassed = customActionHandler
    }
    
    static func initialize(appName: String, baseURL: URL?, networkingDispatcher: URLRequestDispatching?, appBundle: Bundle?, deepLinkHandler: BeagleDeepLinkScreenManaging?, applicationTheme: Theme?, validatorHandler: ValidatorHandler?, customActionHandler: CustomActionHandler?) {
        initialize(
            appName: appName,
            baseURL: baseURL,
            decoder: WidgetDecodingDummy(),
            networkingDispatcher: networkingDispatcher ?? URLRequestDispatchingDummy(),
            customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderDummy(),
            appBundle: appBundle ?? Bundle.main,
            deepLinkHandler: deepLinkHandler,
            applicationTheme: applicationTheme ?? AppThemeDummy(),
            validatorHandler: nil,
            customActionHandler: nil
        )
    }

    private(set) var registerCustomWidgetsCalled = false
    private(set) var itemPassed: Any?
    func registerCustomWidget<E, W>(_ item: WidgetRegisterItem<E, W>) where E : WidgetConvertible, E : WidgetEntity, W : Widget {
        registerCustomWidgetsCalled = true
        itemPassed = item
    }

    private(set) var configureThemeCalled = false
    private(set) var themePassed: Theme?
    func configureTheme(_ theme: Theme) {
        configureThemeCalled = true
        themePassed = theme
    }
    
    private(set) var configureValidatorHandlerCalled = false
    private(set) var validatorHandlerPassed: ValidatorHandler?
    func configureValidatorHandler(_ validatorHandler: ValidatorHandler?) {
        configureValidatorHandlerCalled = true
        validatorHandlerPassed = validatorHandler
    }
    
    private(set) var configureCustomActionHandlerCalled = false
    private(set) var customActionHandlerPassed: CustomActionHandler?
    func configureCustomActionHandler(_ customActionHandler: CustomActionHandler?) {
        configureCustomActionHandlerCalled = true
        customActionHandlerPassed = customActionHandler
    }
}

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
        return try WidgetViewRendererDummy(widget: widget, dependencies: BeagleEnvironment.shared)
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
