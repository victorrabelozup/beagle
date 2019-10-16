//
//  WidgetRendererProviderTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetRendererProviderTests: XCTestCase {

    func test_whenInitializing_shouldReturnInstanceOfWidgetRendererProvider() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.environment = environmentSpy
        Beagle.start()
        let sut = WidgetRendererProviding()

        // When
        let mirror = Mirror(reflecting: sut)
        let customWidgetsProvider = mirror.children.first(where: { $0.label == "customWidgetsProvider" } )

        // Then
        XCTAssertNotNil(customWidgetsProvider, "Expected a `CustomWidgetsRendererProviderRegister` instance, but got nil.")
    }
    
    func test_buildRendererWithUnkownWidget_shouldReturnAnWidgetViewRenderer() {
        // Given
        let rendererProvider = WidgetRendererProviding(customWidgetsProvider: CustomWidgetsRendererProviderDequeuingStub())
        let unkownWidget = WidgetDummy()
        // When
        let widgetViewRenderer = rendererProvider.buildRenderer(for: unkownWidget)
        // Then
        XCTAssertNotNil(widgetViewRenderer, "Expected a unknown Widget View renderer, but got nil.")
        XCTAssertTrue(widgetViewRenderer is UnknownWidgetViewRenderer, "Expected a type to be Unknown Widget, but it is not.")
    }
    
}

// MARK: - Testing Helpers

struct WidgetDummy: Widget {}

private class CustomWidgetsRendererProviderDequeuingStub: CustomWidgetsRendererProviderDequeuing {
    
    var rendererToReturn: WidgetViewRendererProtocol?
    var errorToThrow: Error = NSError(domain: "CustomWidgetsRendererProviderDequeuingStub", code: 1, userInfo: nil)
    func dequeueRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        if let rendererToReturn = rendererToReturn {
            return rendererToReturn
        }
        throw errorToThrow
    }
    
}
