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
        let sut = WidgetRendererProviding()
        
        // When
        let widgetRendererProvidingMirror = Mirror(reflecting: sut)
        guard let layoutRendererProvider = widgetRendererProvidingMirror.children.first else {
            XCTFail("Unable to create LayoutRenderer Provider.")
            return
        }
        
        //Then
        XCTAssertNotNil(sut, "Expected creation of a object, but got none.")
        XCTAssert(layoutRendererProvider.value is LayoutWidgetRendererProviding, "Expected creation of LayoutWidgetRenderer, but got \(type(of: layoutRendererProvider.value))")
    }
    
    func test_buildRendererWithUnkownWidget_shouldReturnAnWidgetViewRenderer() {
        // Given
        let rendererProvider = WidgetRendererProviding()
        let unkownWidget = WidgetDummy()
        // When
        let widgetViewRenderer = rendererProvider.buildRenderer(for: unkownWidget)
        // Then
        XCTAssertNotNil(widgetViewRenderer, "Expected a unknown Widget View renderer, but got nil.")
        XCTAssertTrue(widgetViewRenderer is UnknownWidgetViewRenderer, "Expected a type to be Unknown Widget, but it is not.")
    }
}

// MARK: - Testing Helper

private struct WidgetDummy: Widget {}
