//
//  CustomWidgetsRendererProviderRegisterTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 15/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class CustomWidgetsRendererProviderRegisterTests: XCTestCase {

    // MARK: - CustomWidgetsRendererProviderRegister Tests
    
    func test_register_shouldArchiveTheRegisteredType() {
        // Given
        let sut = CustomWidgetsRendererProviderRegister()
        
        // When
        sut.registerRenderer(DummyRenderer.self, for: WidgetDummy.self)
        
        // Then
        let renderers = Mirror(reflecting: sut).firstChild(of: [String: WidgetViewRenderer.Type].self, in: "renderers")
        let containsDummyRenderer = renderers?.values.contains(where: { $0.self == DummyRenderer.self } ) ?? false
        XCTAssertEqual(renderers?.keys.count, 1, "Expected to have 1 key, but found \(String(describing: renderers?.keys.count)).")
        XCTAssertTrue(containsDummyRenderer, "Expected to have a `DummyRenderer`, but it didn't.")
    }
    
    func test_dequeue_shouldRecoverTheExpectedRenderer_whenPreviouslyRegistered() {
        // Given
        let dummyWidget = WidgetDummy()
        let sut = CustomWidgetsRendererProviderRegister()
        sut.registerRenderer(DummyRenderer.self, for: WidgetDummy.self)
        
        // When
        let renderer = try? sut.dequeueRenderer(for: dummyWidget)
        
        // Then
        XCTAssertNotNil(renderer, "Expected a `renderer` instance, but got nil.")
        XCTAssertTrue(renderer is DummyRenderer, "Expected a `DummyRenderer` but got something else.")
    }
    
    func test_dequeue_shouldThrowError_whenTryingToGetAWidgetToUnknownWidget() {
        // Given
        let dummyWidget = WidgetDummy()
        let sut = CustomWidgetsRendererProviderRegister()
        
        // When / Then
        XCTAssertThrowsError(_ = try sut.dequeueRenderer(for: dummyWidget), "Expected an error, but got nothing.") { error in
            XCTAssertTrue(error is CustomWidgetsRendererProviderRegisterError)
        }
    }
    
    // MARK: - CustomWidgetsRendererProviderRegisterError Tests
    
    func test_CustomWidgetsRendererProviderRegisterError_localizedDescription_shouldReturnCorrectText() {
        // Given
        let typeName = "Something"
        let expectedLocalizedDescription = "Could not find renderer for Widget of type \(typeName)."
        
        // When
        let error: CustomWidgetsRendererProviderRegisterError = .couldNotFindRendererForWidgetOfType(typeName)
        let localizedDescription = error.localizedDescription
        
        // Then
        XCTAssertEqual(expectedLocalizedDescription, localizedDescription, "Expected \(expectedLocalizedDescription), but got \(localizedDescription).")
    }
    
}

// MARK: - Testing Helpers
private class DummyRenderer: WidgetViewRenderer {
    
    private let widget: WidgetDummy
    
    required init(_ widget: Widget) throws {
        self.widget = try .newByCasting(widget: widget, to: WidgetDummy.self)
    }
    
    func buildView() -> UIView {
        return DummyView()
    }
    
}

private class DummyView: UIView {}

//func dequeueRenderer(for widget: Widget) throws -> WidgetViewRenderer {
//    let widgetTypeName = String(describing: type(of: widget))
//    guard let rendererType = renderers[widgetTypeName] else {
//        throw CustomWidgetsRendererProviderRegisterError.couldNotFindRendererForWidgetOfType(widgetTypeName)
//    }
//    return try rendererType.init(widget)
//}
