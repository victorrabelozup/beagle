//
//  InputWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class InputWidgetEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let child = AnyDecodableContainer(content: TextEntity(text: "text"))
        let sut = FormInputEntity(
            name: "",
            required: false,
            validator: "coisa",
            errorMessage: nil,
            child: child
        )
        
        // When
        let form = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(form, "FormInput widget should not be nil.")
        XCTAssertTrue(form is FormInput)
    }
    
}
