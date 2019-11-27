//
//  CustomActionEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class CustomActionEntityTests: XCTestCase {
    
    func test_whenMapToActionIsCalled_thenItShouldReturnACustomAction() {
        // Given
        let sut = CustomActionEntity(name: "custom", data: ["x": "y"])
        
        // When
        guard let action = try? sut.mapToAction() else {
            XCTFail("Could not create CustomAction Model.")
            return
        }
        let customAction = action as? CustomAction

        // Then
        XCTAssertNotNil(customAction)
        XCTAssertEqual(customAction?.name, "custom")
        XCTAssertEqual(customAction?.data, ["x": "y"])
    }
    
}
