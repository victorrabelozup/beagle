//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ImageEntityTests: XCTestCase {

    func test_whenMapToComponentIsCalled_thenItShouldReturnAImage() {
        // Given
        let sut = ImageEntity(name: "Beagle", contentMode: .fitXY, accessibility: nil, appearance: nil, flex: nil)
        
        // When
        let image = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(image, "The Image component should not be nil.")
        XCTAssertTrue(image is Image)
    }
}
