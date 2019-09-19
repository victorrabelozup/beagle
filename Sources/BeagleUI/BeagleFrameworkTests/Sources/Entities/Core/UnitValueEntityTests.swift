//
//  UnitValueEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UnitValueEntityTests: XCTestCase {
    
    func test_whenMapToUIModelIsCalledForReal_thenItShouldReturnAValidUnitValue() {
        // Given
        let expectedUIModel = UnitValue(value: 1.0, type: .real)
        let sut = UnitValueEntity(value: 1.0, type: .real)
        
        // When
        let uiModel = sut.mapToUIModel()
        
        // Then
        XCTAssertEqual(uiModel, expectedUIModel, "Expected \(expectedUIModel), but got \(uiModel)")
    }
    
    func test_whenMapToUIModelIsCalledForPercent_thenItShouldReturnAValidUnitValue() {
        // Given
        let expectedUIModel = UnitValue(value: 1.0, type: .percent)
        let sut = UnitValueEntity(value: 1.0, type: .percent)
        
        // When
        let uiModel = sut.mapToUIModel()
        
        // Then
        XCTAssertEqual(uiModel, expectedUIModel, "Expected \(expectedUIModel), but got \(uiModel)")
    }
    
}

extension UnitValue: Equatable {
    public static func == (lhs: UnitValue, rhs: UnitValue) -> Bool {
        return lhs.type == rhs.type && lhs.value == rhs.value
    }
}
