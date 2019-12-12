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
    
    func test_buildRendererWithUnkownWidget_shouldReturnAnWidgetViewRenderer() {
        // Given
        let provider = WidgetRendererProviding()
        provider.providers = [CustomRendererProviderStub()]

        // When
        let renderer = provider.buildRenderer(for: WidgetDummy(), dependencies: RendererDependenciesContainer())

        // Then
        XCTAssertNotNil(renderer, "Expected a unknown Widget View renderer, but got nil.")
        XCTAssertTrue(renderer is UnknownWidgetViewRenderer, "Expected a type to be Unknown Widget, but it is not.")
    }

    func test_widgetsRendererProviderError_localizedDescription_shouldReturnCorrectText() {
        // Given
        let widget = WidgetDummy()
        let expectedError = "WidgetDummy has no renderer's registered, please check this."

        // When
        let error = WidgetRendererProviding.Error.couldNotFindRendererForWidget(widget)

        // Then
        XCTAssertEqual(expectedError, error.localizedDescription)
    }
    
}

// MARK: - Testing Helpers

struct WidgetDummy: NativeWidget {}

private class CustomRendererProviderStub: CustomWidgetsRendererProvider {

    var rendererToReturn: WidgetViewRendererProtocol?
    var errorToThrow: Error = NSError(domain: "CustomWidgetsRendererProviderDequeuingStub", code: 1, userInfo: nil)

    func registerRenderer<W>(_ rendererType: WidgetViewRenderer<W>.Type, for widgetType: W.Type) where W : Widget {}

    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) throws -> WidgetViewRendererProtocol {
        if let rendererToReturn = rendererToReturn {
            return rendererToReturn
        }
        throw errorToThrow
    }
}

struct ActionDummy: Action {}
