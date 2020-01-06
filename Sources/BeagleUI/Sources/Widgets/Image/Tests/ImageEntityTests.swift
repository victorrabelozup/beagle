//
//  ImageEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 15/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ImageEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAImage() {
        // Given
        let sut = ImageEntity(name: "Beagle", contentMode: .fitXY, appearance: nil)
        
        // When
        let image = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(image, "The Image widget should not be nil.")
        XCTAssertTrue(image is Image)
    }
}
