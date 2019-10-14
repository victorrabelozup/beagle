//
//  FailableWidgetRendererProviderErrorTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FailableWidgetRendererProviderErrorTests: XCTestCase {
    
    func test_localizedDescription_shouldReturnCorrectMessage() {
        // Given
        let unrenderedWidget = WidgetDummy()
        let expectedLocalizedDescription = "\(String(describing: unrenderedWidget)) has no renderer's registered, please check this."
        
        // When
        let error: FailableWidgetRendererProviderError = .couldNotFindRenrererForWidget(unrenderedWidget)
        let localizedDescription = error.localizedDescription
        
        // Then
        XCTAssertEqual(expectedLocalizedDescription, localizedDescription, "Expected \(expectedLocalizedDescription), but got \(localizedDescription).")
    }
}

// MARK: - Testing Helpers

private struct WidgetDummy: Widget {}
