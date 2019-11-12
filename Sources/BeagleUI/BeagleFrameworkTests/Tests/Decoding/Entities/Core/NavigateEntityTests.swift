//
//  NavigateEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 08/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigateEntityTests: XCTestCase {
    
    func test_whenMapToUIModelIsCalled_thenItShouldReturnANavigate() {
        // Given
        let sut = NavigateEntity(type: .addView, path: nil, data: nil)
        
        // When
        guard let navigate = try? sut.mapToUIModel() else {
            XCTFail("Could not create Navigate Model.")
            return
        }

        // Then
        XCTAssertNotNil(navigate, "The Navigate should not be nil.")
    }
    
}
