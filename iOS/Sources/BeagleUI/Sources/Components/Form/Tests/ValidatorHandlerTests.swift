/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class ValidatorHandlerTests: XCTestCase {
    
    func test_getValidator_shouldReturnTheValidator() {
        // Given
        let sut = ValidatorProviding()
        let validatorName = "custom-validator"
        let validInput = "Valid Input"
        sut[validatorName] = {
            $0 as? String == validInput
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
        let sut = ValidatorProviding()
        let validatorName = "custom-validator"
        sut[validatorName] = nil
                
        // When
        let validator = sut.getValidator(name: validatorName)
        
        // Then
        XCTAssertNil(validator)
    }
    
}
