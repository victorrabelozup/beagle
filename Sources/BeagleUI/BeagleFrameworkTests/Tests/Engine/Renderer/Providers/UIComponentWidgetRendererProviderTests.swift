//
//  UIComponentWidgetRendererProviderTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIComponentWidgetRendererProviderTests: XCTestCase {

    func test_whenBuildinRendererUIComponentWidgetWithouRenderer_shouldThrowError() {
        // Given
        let unrenderedWidget = WidgetDummy()
        let uiComponentWidgetRendererProvider = UIComponentWidgetRendererProviding()
        
        // When/ Then
        XCTAssertThrowsError(_ = try uiComponentWidgetRendererProvider.buildRenderer(for: unrenderedWidget), "Expected error to be thrown, but got none.") { error in
            XCTAssert(error is FailableWidgetRendererProviderError, "Expected a FailableWidgetRendererProviderError, but got \(error.localizedDescription)")
        }
    }
}
