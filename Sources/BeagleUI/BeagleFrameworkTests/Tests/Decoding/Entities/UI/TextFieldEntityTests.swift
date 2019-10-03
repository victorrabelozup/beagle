//
//  TextFieldEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TextFieldEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAStyledWidget() {
        // Given
        let sut = TextFieldEntity(hint: nil, value: nil)
        
        // When
        let textField = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(textField, "The TextField widget should not be nil.")
        XCTAssertTrue(textField is TextField)
    }

}
