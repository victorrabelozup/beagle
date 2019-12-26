//
//  WidgetConvertibleTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 25/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetConvertibleTests: XCTestCase {
    
    func test_localizedDescription_shouldReturnTheCorrectTextForEntityTypeIsNotConvertible() {
        // Given
        let type = "Something"
        let expectedLocalizedDescription = "\(type) does not conform with `WidgetConvertible`. Check this."
        
        // When
        let error: WidgetConvertibleError = .entityTypeIsNotConvertible(type)
        let localizedDescription = error.localizedDescription
        
        // Then
        XCTAssertEqual(expectedLocalizedDescription, localizedDescription, "Expected \(expectedLocalizedDescription), but got \(localizedDescription).")
    }
    
}
