//
//  LayoutWidgetRendererProvidingTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LayoutWidgetRendererProvidingTests: XCTestCase {
    
    func test_whenBuildinRendererWidgetWithouRenderer_shouldThrowError() {
        // Given
        let unrenderedWidget = WidgetDummy()
        let layoutWidgetRendererProvider = LayoutWidgetRendererProviding()
        
        // When/ Then
        XCTAssertThrowsError(_ = try layoutWidgetRendererProvider.buildRenderer(for: unrenderedWidget), "") { error in
            XCTAssertNotNil(error, "Expected error to be thrown, but got \(error.localizedDescription)")
        }
    }
}

// MARK: - Testing Helpers

private struct WidgetDummy: Widget {}
