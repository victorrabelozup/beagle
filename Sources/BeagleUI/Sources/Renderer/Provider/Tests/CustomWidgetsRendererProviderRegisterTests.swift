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

    private let dependencies = RendererDependenciesContainer()

    func test_register_shouldArchiveTheRegisteredType() {
        // Given
        let sut = CustomWidgetsRendererProviding()
        
        // When
        sut.registerRenderer(DummyRenderer.self, for: WidgetDummy.self)
        
        // Then
        let renderers = Mirror(reflecting: sut).firstChild(of: [String: Any.Type].self, in: "renderers")
        let containsDummyRenderer = renderers?.values.contains { $0.self == DummyRenderer.self } ?? false
        XCTAssertEqual(renderers?.keys.count, 1, "Expected to have 1 key, but found \(String(describing: renderers?.keys.count)).")
        XCTAssertTrue(containsDummyRenderer, "Expected to have a `DummyRenderer`, but it didn't.")
    }
    
    func test_dequeue_shouldRecoverTheExpectedRenderer_whenPreviouslyRegistered() {
        // Given
        let dummyWidget = WidgetDummy()
        let sut = CustomWidgetsRendererProviding()
        sut.registerRenderer(DummyRenderer.self, for: WidgetDummy.self)
        
        // When
        let renderer = try? sut.buildRenderer(for: dummyWidget, dependencies: dependencies)
        
        // Then
        XCTAssertNotNil(renderer, "Expected a `renderer` instance, but got nil.")
        XCTAssertTrue(renderer is DummyRenderer, "Expected a `DummyRenderer` but got something else.")
    }
    
    func test_dequeue_shouldThrowError_whenTryingToGetAWidgetToUnknownWidget() {
        // Given
        let dummyWidget = WidgetDummy()
        let sut = CustomWidgetsRendererProviding()
        
        // When / Then
        XCTAssertThrowsError(_ = try sut.buildRenderer(for: dummyWidget, dependencies: dependencies), "Expected an error, but got nothing.") { error in
            XCTAssertTrue(error is RendererProviding.Error)
        }
    }
    
}

// MARK: - Testing Helpers
private class DummyRenderer: ViewRendering<WidgetDummy> {
    
    override func buildView(context: BeagleContext) -> UIView {
        return DummyView()
    }
    
}

private class DummyView: UIView {}
