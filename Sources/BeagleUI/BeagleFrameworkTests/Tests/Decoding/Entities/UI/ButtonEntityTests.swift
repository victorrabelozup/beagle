//
//  ButtonEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAButton() {
        // Given
        let sut = ButtonEntity(text: "text")
        
        // When
        let button = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(button, "The Button widget should not be nil.")
        XCTAssertTrue(button is Button)
    }

}
