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
            "_beagleType_": "beagle:widget:newwidget",
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
    
    func test_whenADefaultTypeIsRequested_thenItShouldBeAbleToDecodeIt() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:text",
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
    
    func test_whenAnUnknwonTypeIsDecoded_thenItShouldReturnNil() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:unknown",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        let value = try? sut.decode(from: jsonData)
        
        // Then
        XCTAssertNil(value, "Expected a nil value, but found \(value.debugDescription)).")
    }
    
    func test_whenDecodingAnValidJSONToWidgetToTheWrongWidgetType_thenItShouldThrowAnDecodingError() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        var thrownError: Error?
        do {
            _ = try sut.decodeToWidget(ofType: Button.self, from: jsonData)
        } catch {
            thrownError = error
        }
        
        // Then
        XCTAssertNotNil(thrownError, "Expected throw an error, but it didn't.")
        XCTAssertTrue(thrownError is WidgetDecodingError, "Expected to find a `WidgetDecodingError`, but found \(thrownError.debugDescription).")
    }
    
    func test_whenDecodingAnValidJSONToAValidWidgetType_thenItShouldReturnTheExpectedWidget() {
        // Given
        let expectedText = "some text"
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        
        // When
        let value = try? sut.decodeToWidget(ofType: Text.self, from: jsonData)
        
        // Then
        XCTAssertNotNil(value, "Expected a TextEntity, but found nil.")
        XCTAssertEqual(value?.text, expectedText, "The `text` property is not as expected.")
    }
    
    func test_whenAplyingAValidTransformation_thenItShouldSucceed() {
        // Given
        let expectedText = "some text"
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }

        // When
        let transformer: (Widget) -> Text? = { $0 as? Text }
        let value = try? sut.decode(from: jsonData, transformer: transformer)

        // Then
        XCTAssertNotNil(value, "Expected a valid Text, but found nil.")
        XCTAssertEqual(value?.text, expectedText, "The `text` property is not as expected.")
    }
    
    func test_whenTryingToDecodeAnInvalidJSON_thenItShouldReturnEntityTypeIsNotConvertibleError() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:unconvertiblewidget",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        sut.register(UnconvertibleWidget.self, for: "UnconvertibleWidget")

        // When
        
        var thrownError: Error?
        var transformedObject: UnconvertibleWidget?
        do {
            let transformer: (Widget) -> UnconvertibleWidget? = { $0 as? UnconvertibleWidget }
            transformedObject = try sut.decode(from: jsonData, transformer: transformer)
        } catch {
            thrownError = error
        }
        
        // Then
        XCTAssertNil(thrownError)
        XCTAssertNil(transformedObject)
    }
    
}

// MARK: - Testing Helpers
private struct NewWidgetEntity: WidgetEntity, WidgetConvertible {
    
    let something: String
    
    func mapToWidget() throws -> Widget {
        return Text(something)
    }
    
}

struct UnconvertibleWidget: WidgetEntity {
    let text: String
}
