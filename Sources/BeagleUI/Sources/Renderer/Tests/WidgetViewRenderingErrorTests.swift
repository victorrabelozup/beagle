//
//  WidgetViewRenderingErrorTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetViewRenderingErrorTests: XCTestCase {
    
    func test_localizedDescription_shouldReturnCorrectTextWhenUnableToCastWidgetToType() {
        // Given
        let type = "Something"
        let expectedLocalizedDescription = "Could not cast widget to `\(type)`."
        
        // When
        let error: ViewRendererError = .couldNotCastWidgetToType(type)
        let localizedDescription = error.localizedDescription
        
        // Then
        XCTAssertEqual(expectedLocalizedDescription, localizedDescription, "Expected \(expectedLocalizedDescription), but got \(localizedDescription).")
    }
    
}
