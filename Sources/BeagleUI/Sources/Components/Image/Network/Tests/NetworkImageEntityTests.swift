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

    func test_whenMapToComponentIsCalled_thenItShouldReturnANetworkImage() {
        // Given
        let sut = NetworkImageEntity(path: "https://teste.com", contentMode: .center, appearance: nil)
        
        // When
        let networkImage = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(networkImage, "The NetworkImage component should not be nil.")
        XCTAssertTrue(networkImage is NetworkImage)
    }
}
