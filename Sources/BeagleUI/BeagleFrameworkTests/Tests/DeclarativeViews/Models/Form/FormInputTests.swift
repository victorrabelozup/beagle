//
//  FormInputTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormInputTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidFormInput() {
        // Given / When
        let sut = FormInput(name: "name") {
            Text("Text")
        }
        // Then
        XCTAssertTrue(sut.child is Text, "Expected `Text`, but got \(String(describing: sut.child))")
    }
    
}
