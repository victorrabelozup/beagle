//
//  FormEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let childContainer = AnyDecodableContainer(content: TextEntity(text: "text"))
        let sut = FormEntity(
            action: "action",
            method: .get,
            child: childContainer
        )
        
        // When
        let form = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(form, "Form widget should not be nil.")
        XCTAssertTrue(form is Form)
    }
    
}
