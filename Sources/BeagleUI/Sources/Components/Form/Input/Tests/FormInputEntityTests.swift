//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class InputComponentEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnAFormEntity() {
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
        let form = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(form, "FormInput component should not be nil.")
        XCTAssertTrue(form is FormInput)
    }
    
}
