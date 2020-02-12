//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnAFormEntity() {
        // Given
        let childContainer = AnyDecodableContainer(content: TextEntity(text: "text"))
        let sut = FormEntity(
            path: "action",
            method: .get,
            child: childContainer
        )
        
        // When
        let form = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(form, "Form component should not be nil.")
        XCTAssertTrue(form is Form)
    }
    
}
