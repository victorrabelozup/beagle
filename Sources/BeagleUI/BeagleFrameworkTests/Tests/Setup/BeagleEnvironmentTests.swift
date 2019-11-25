//
//  BeagleEnvironmentTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI
import Networking

final class BeagleEnvironmentTests: XCTestCase {
    
    func test_fatalErrorShouldBeThrown_whenSharedIsAccessedBeforeBeingInitialized() {
        // Given / When / Then
        expectFatalError(expectedMessage: "BeagleEnvironment was not initialized, check that!") {
                _ = BeagleEnvironment.shared
        }
    }
    
    func test_initialize_shouldSetupTheDependeciesCorrectly() {
        // Given
        let appName = "AppName"
        let bundle = Bundle()
        let deepLinkHandler = DeepLinkHandlerDummy()
        
        // When
        BeagleEnvironment.initialize(appName: appName, appBundle: bundle, deepLinkHandler: deepLinkHandler)
        let environment = BeagleEnvironment.shared
        
        let mirror = Mirror(reflecting: environment)
        let decoder = mirror.firstChild(of: WidgetDecoder.self, in: "_decoder")
        let networkingDispatcher = mirror.children.first(where: { $0.label == "_networkingDispatcher" } )
        let customWidgetsRendererProviderRegister = mirror.firstChild(of: CustomWidgetsRendererProviderRegister.self, in: "customWidgetsRendererProviderRegister")
        
        // Then
        XCTAssertNotNil(decoder, "Expected a `decoder` to be set.")
        XCTAssertTrue(environment.decoder is WidgetDecoder)
        XCTAssertNotNil(networkingDispatcher, "Expected a `networkingDispatcher` to be set.")
        XCTAssertTrue(environment.networkingDispatcher is URLSessionDispatcher)
        XCTAssertNotNil(customWidgetsRendererProviderRegister, "Expected a `customWidgetsRendererProviderRegister` to be set.")
        XCTAssertTrue(environment.customWidgetsProvider is CustomWidgetsRendererProviderRegister)
        XCTAssertEqual(bundle, environment.appBundle, "Expected a `appBundle` to be set.")
        XCTAssertNotNil(deepLinkHandler, "Expected a `deepLinkHandler` to be set.")
    }
    
    func test_initialize_whenAppBundleItsNotPassed_shouldSetMainBundle() {
        // Given
        let appName = "AppName"
        let expectedBundle = Bundle.main
        
        // When
        BeagleEnvironment.initialize(appName: appName, deepLinkHandler: DeepLinkHandlerDummy())
        let environment = BeagleEnvironment.shared
        
        // Then
        XCTAssertEqual(expectedBundle, environment.appBundle, "Expected a `appBundle` to be Bundle.main.")
    }
    
    func test_registerCustomWidgets_shouldCallDecoderAndCustomWidgersRendererProviderRegister() {
        // Given
        let decoderSpy = WidgetDecodingSpy()
        let widgetRegisterSpy = CustomWidgetsRendererProviderRegisterSpy()
        BeagleEnvironment.initialize(
            appName: "EnvironmentTest",
            decoder: decoderSpy,
            networkingDispatcher: URLRequestDispatchingDummy(),
            customWidgetsRendererProviderRegister: widgetRegisterSpy,
            appBundle: Bundle.main,
            deepLinkHandler: DeepLinkHandlerDummy(),
            applicationTheme: AppThemeDummy()
        )
        let sut: BeagleEnvironmentProtocol = BeagleEnvironment.shared
        
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
        sut.registerCustomWidget(customWidgetToRegister)
        
        // Then
        XCTAssertTrue(decoderSpy.registerTypeCalled)
        XCTAssertTrue(decoderSpy.typePassedToRegister is WidgetDummyEntity.Type)
        XCTAssertEqual(decoderSpy.typeNamePassedToRegister, customWidgetToRegister.entity.typeName)
        XCTAssertTrue(widgetRegisterSpy.registerRendererCalled)
        XCTAssertTrue(widgetRegisterSpy.widgetTypePassed is WidgetDummy.Type)
        XCTAssertTrue(widgetRegisterSpy.rendererTypePassed is WidgetViewRendererDummy.Type)
    }
    
}

// MARK: - Testing Helpers

private final class WidgetDecodingSpy: WidgetDecoding {
    
    private(set) var registerTypeCalled = false
    private(set) var typePassedToRegister: WidgetEntity.Type?
    private(set) var typeNamePassedToRegister: String?
    func register<T>(_ type: T.Type, for typeName: String) where T : WidgetEntity {
        registerTypeCalled = true
        typePassedToRegister = type
        typeNamePassedToRegister = typeName
    }
    
    private(set) var decodeToWidgetCalled = false
    private(set) var dataPassedToDecodeToWidget: Data?
    func decode(from data: Data) throws -> Widget {
        decodeToWidgetCalled = true
        dataPassedToDecodeToWidget = data
        return WidgetDummy()
    }
}

private final class CustomWidgetsRendererProviderRegisterSpy: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing {
    
    private(set) var registerRendererCalled = false
    private(set) var rendererTypePassed: WidgetViewRendererProtocol.Type?
    private(set) var widgetTypePassed: Widget.Type?
    func registerRenderer<W>(_ rendererType: WidgetViewRenderer<W>.Type, for widgetType: W.Type) where W : Widget {
        registerRendererCalled = true
        rendererTypePassed = rendererType
        widgetTypePassed = widgetType
    }
    
    private(set) var dequeueRendererCalled = false
    private(set) var widgetPassed: Widget?
    func dequeueRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        dequeueRendererCalled = true
        widgetPassed = widget
        return try WidgetViewRendererDummy(widget)
    }
    
}
