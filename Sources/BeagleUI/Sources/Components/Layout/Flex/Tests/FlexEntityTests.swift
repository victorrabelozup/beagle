//
//  FlexEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexEntityTests: XCTestCase {
    
    func test_whenMapToUIModelIsCalled_thenItShouldReturnAFlex() {
        // Given
        let sut = FlexEntity()

        // When
        guard let flex = try? sut.mapToUIModel() else {
            XCTFail("Could not create Flex Model.")
            return
        }

        // Then
        XCTAssertNotNil(flex, "The Flex should not be nil.")
    }
    
    func test_whenMapToUIModelIsCalled_thenItShouldReturnAEdgeValue() {
        // Given
        let sut = FlexEntity.EdgeValue()

        // When
        guard let edgeValue = try? sut.mapToUIModel() else {
            XCTFail("Could not create Flex.EdgeValue Model.")
            return
        }

        // Then
        XCTAssertNotNil(edgeValue, "The EdgeValue should not be nil.")
    }
    
    func test_whenMapToUIModelIsCalled_thenItShouldReturnASize() {
        // Given
        let sut = FlexEntity.Size()

        // When
        guard let size = try? sut.mapToUIModel() else {
            XCTFail("Could not create Flex.Size Model.")
            return
        }

        // Then
        XCTAssertNotNil(size, "The Size should not be nil.")
    }
}
