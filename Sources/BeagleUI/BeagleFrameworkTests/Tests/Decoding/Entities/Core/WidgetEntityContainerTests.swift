//
//  WidgetEntityContainerTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 25/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetEntityContainerTests: XCTestCase {

    func test_localizedDescriptionShouldReturnTheCorrectText() {
        // Given
        let type = "Something"
        let expectedLocalizedDescription = "Could not cast value to Something"
        
        // When
        let error: WidgetEntityContainer.Error = .cannotCastValueToType(type)
        let localizedDescription = error.localizedDescription
        
        // Then
        XCTAssertEqual(expectedLocalizedDescription, localizedDescription, "Expected \(expectedLocalizedDescription), but got \(localizedDescription).")
    }

}
