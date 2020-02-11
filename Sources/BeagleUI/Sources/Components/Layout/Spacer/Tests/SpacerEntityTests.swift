//
//  SpacerEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SpacerEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnASpacerComponent() {
        // Given
        let sut = SpacerEntity(size: 1.0)
        
        // When
        let spacerEntity = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(spacerEntity, "The Spacer component should not be nil.")
        XCTAssertTrue(spacerEntity is Spacer)
    }

}
