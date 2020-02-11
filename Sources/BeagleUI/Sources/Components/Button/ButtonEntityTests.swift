//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonEntityTests: XCTestCase {

    func test_whenMapToComponentIsCalled_thenItShouldReturnAButton() {
        // Given
        let sut = ButtonEntity(text: "text")
        
        // When
        let button = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(button, "The Button component should not be nil.")
        XCTAssertTrue(button is Button)
    }
}
