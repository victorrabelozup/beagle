//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormValidationEntityTests: XCTestCase {
    
    func test_whenMapToActionIsCalled_thenItShouldReturnAFormValidation() {
        // Given
        let error = FieldErrorEntity(inputName: "name", message: "message")
        let sut = FormValidationEntity(errors: [error])
        
        // When
        guard let action = try? sut.mapToAction() else {
            XCTFail("Could not create FormValidation Model.")
            return
        }
        let formValidation = action as? FormValidation

        // Then
        XCTAssertNotNil(formValidation)
        XCTAssertEqual(formValidation?.errors.count, 1)
        XCTAssertEqual(formValidation?.errors.first?.inputName, "name")
        XCTAssertEqual(formValidation?.errors.first?.message, "message")
    }
    
}
