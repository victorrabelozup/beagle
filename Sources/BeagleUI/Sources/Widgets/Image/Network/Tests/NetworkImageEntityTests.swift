//
//  ImageEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 15/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkImageEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnANetworkImage() {
        // Given
        let sut = NetworkImageEntity(url: "https://teste.com", contentMode: .center)
        
        // When
        let networkImage = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(networkImage, "The NetworkImage widget should not be nil.")
        XCTAssertTrue(networkImage is NetworkImage)
    }
}
