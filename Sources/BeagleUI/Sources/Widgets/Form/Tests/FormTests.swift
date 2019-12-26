//
//  FormTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidForm() {
        // Given / When
        let sut = Form(action: "action", method: .get) {
            Text("Teste")
        }
        // Then
        XCTAssertTrue(sut.child is Text, "Expected `Text`, but got \(String(describing: sut.child))")
    }
    
}
