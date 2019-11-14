//
//  FormSubmitTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormSubmitTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidFormSubmit() {
        // Given / When
        let sut = FormSubmit {
            Text("Text")
        }
        // Then
        XCTAssertTrue(sut.child is Text, "Expected `Text`, but got \(String(describing: sut.child))")
    }
    
}
