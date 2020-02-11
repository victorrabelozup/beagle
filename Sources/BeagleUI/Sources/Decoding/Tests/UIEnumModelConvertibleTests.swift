//
//  UIEnumModelConvertibleTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 20/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIEnumModelConvertibleTests: XCTestCase {

    func test_whenAUIEnumRawValueIsNotAString_itShouldReturnAnError() {
        // Given
        let sut: BadItemDirectionEntity = .inherit

        // When / Then
        XCTAssertThrowsError(
            try sut.mapToUIModel(ofType: ItemDirection.self),
            "Expected to Throw an error, but it didn't."
        )
    }
    
    func test_whenAUIEnumDoesNotHaveTheSameCasesAsTheEntity_itShouldReturnAnError() {
        // Given
        let sut: ItemDirectionEntity = .inherited
        
        // When / Then
        XCTAssertThrowsError(
            try sut.mapToUIModel(ofType: ItemDirection.self),
            "Expected to Throw an error, but it didn't."
        )
    }
    
    func test_whenAUIEnumaAndItsEntityAreTheSame_itShouldReturnAValidEnum() {
        // Given
        let sut: ItemDirectionEntity = .inherited
        
        // When
        let godEnum = try? sut.mapToUIModel(ofType: GodItemDirection.self)
        
        // Then
        XCTAssertNotNil(godEnum, "Expected a valid enum, but found nil.")
    }
    
    func test_whenUIModelConversionErrorLocalizedDescriptionIsCalled_itShouldReturnTheCorrectTexts() {
        // Given
        let expectedType = "MyType"
        let expectedLocalizedDescriptions = [
            "The UIModel could not be initialized for \(expectedType), check it's entity cases.",
            "The Entity Enum does not has a RawValue == String on \(expectedType). Check that."
        ]
        let cases: [UIModelConversionError] = [.couldNotInitializeEnumOfType(expectedType), .rawValueIsNotOfStringForType(expectedType)]

        // When
        let localizedDescriptions = cases.map { $0.localizedDescription }

        // Then
        XCTAssertEqual(expectedLocalizedDescriptions, localizedDescriptions, "The `localizedDescriptions` doesn't match, when they should.")
    }
    
}

// MARK: - Testing Helpers
private enum BadItemDirectionEntity: Int, ComponentEntity, UIEnumModelConvertible {
    case inherit = 1
}

private enum ItemDirectionEntity: String, ComponentEntity, UIEnumModelConvertible {
    case inherited
}

private enum GodItemDirection: String, ComponentEntity, StringRawRepresentable {
    case inherited
}

private enum ItemDirection: String, ComponentEntity, StringRawRepresentable {
    case inherit
}
