//
//  WidgetDecoderTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetDecoderTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var sut = WidgetDecoder()
    
    // MARK: - Tests
    
    func test_whenANewTypeIsRegistered_thenItShouldBeAbleToDecodeIt() {
        // Given
        guard let jsonData = """
        {
            "type": "beagle:NewWidget",
            "something": "something"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        sut.register(NewWidgetEntity.self, for: "NewWidget")
        
        // Then
        let value = try? sut.decode(from: jsonData)
        XCTAssertNotNil(value, "Expected a NewWidgetEntity, but found nil.")
        XCTAssertTrue(value is NewWidgetEntity, "Expected a NewWidgetEntity type.")
    }
    
    func test_whenDecodingToContainer_thenItShouldFindAValidValue() {
        // Given
        guard let jsonData = """
        {
            "type": "beagle:Text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        let value = try? sut.decodeToContainer(from: jsonData)
        
        // Then
        XCTAssertNotNil(value, "Expected a WidgetEntityContainer, but found nil.")
        XCTAssertNotNil(value?.content, "Expected a valid `content`, but found nil.")
    }
    
    func test_whenADefaultTypeIsRequested_thenItShouldBeAbleToDecodeIt() {
        // Given
        guard let jsonData = """
        {
            "type": "beagle:Text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        let value = try? sut.decode(from: jsonData)
        
        // Then
        XCTAssertNotNil(value, "Expected a TextEntity, but found nil.")
        XCTAssertTrue(value is TextEntity, "Expected a TextEntity type.")
    }
    
    func test_whenAplyingAValidTransformation_thenItShouldSucceed() {
        // Given
        let expectedText = "some text"
        guard let jsonData = """
        {
            "type": "beagle:Text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        let transformer: (WidgetEntity) -> TextEntity? = { $0 as? TextEntity }
        let value = try? sut.decode(from: jsonData, transformer: transformer)
        
        // Then
        XCTAssertNotNil(value, "Expected a valid TextEntity, but found nil.")
        XCTAssertEqual(value?.text, expectedText, "The `text` property is not as expected.")
    }
    
    func test_whenTryingToDecodeAnInvalidJSON_thenItShouldReturnAnError() {
        // Given
        guard let jsonData = """
        {
            : "beagle:UnknownWidget",
            "content": {
                "something": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When / Then
        let transformer: (WidgetEntity) -> TextEntity? = { $0 as? TextEntity }
        XCTAssertThrowsError(
            try sut.decode(from: jsonData, transformer: transformer),
            "Expected to Throw an error, but it didn't."
        )
    }
    
}

// MARK: - Testing Helpers
private struct NewWidgetEntity: WidgetEntity, WidgetConvertible {
    
    let something: String
    
    func mapToWidget() throws -> Widget {
        return Text(text: something)
    }
    
}

private struct UnknownWidgetEntity: WidgetEntity {
    let something: String
}
