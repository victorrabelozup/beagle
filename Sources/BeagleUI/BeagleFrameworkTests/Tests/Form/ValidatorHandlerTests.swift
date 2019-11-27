//
//  ValidatorHandlerTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ValidatorHandlerTests: XCTestCase {
    
    func test_getValidator_shouldReturnTheValidator() {
        // Given
        let sut = ValidatorHandling()
        let validatorName = "custom-validator"
        let validInput = "Valid Input"
        sut[validatorName] = {
            return $0 as? String == validInput
        }
        
        // When
        let validator = sut.getValidator(name: validatorName)
        let validationResult = validator?.isValid(input: validInput)
        
        // Then
        XCTAssertNotNil(validator)
        XCTAssertNotNil(sut[validatorName])
        XCTAssertTrue(validationResult ?? false)
    }
    
    func test_removedValidator_shouldReturnNil() {
        // Given
        let sut = ValidatorHandling()
        let validatorName = "custom-validator"
        sut[validatorName] = nil
                
        // When
        let validator = sut.getValidator(name: validatorName)
        
        // Then
        XCTAssertNil(validator)
    }
    
}
