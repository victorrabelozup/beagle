//
//  FormSubmitEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormSubmitEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let child = AnyDecodableContainer(content: TextEntity(text: "text"))
        let sut = FormSubmitEntity(
            child: child
        )
        // When
        let form = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(form, "FormSubmit widget should not be nil.")
        XCTAssertTrue(form is FormSubmit)
    }
}
