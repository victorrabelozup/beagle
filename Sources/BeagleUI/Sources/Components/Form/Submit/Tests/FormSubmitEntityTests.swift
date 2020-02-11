//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormSubmitEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let child = AnyDecodableContainer(content: TextEntity(text: "text"))
        let sut = FormSubmitEntity(child: child, enabled: false)
        // When
        let form = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(form, "FormSubmit component should not be nil.")
        XCTAssertTrue(form is FormSubmit)
    }
}
