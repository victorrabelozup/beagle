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
    
    func test_initWithCustomJsonDecoder_shouldSetupJsonDecoderCorrectly() {
        // Given
        let customDecoder = JSONDecoder()
        
        // When
        let sut = WidgetDecoder(jsonDecoder: customDecoder)
        let custom = Mirror(reflecting: sut).firstChild(of: JSONDecoder.self)
        
        // Then
        XCTAssertTrue(customDecoder === custom)
    }
    
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
        let widget: Widget? = try? sut.decode(from: jsonData)
        let value = widget as? Text
        XCTAssertNotNil(value, "Expected a Text, but found nil.")
        XCTAssertEqual("something", value?.text)
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
        let widget: Widget? = try? sut.decode(from: jsonData)
        let value = widget as? Text

        // Then
        XCTAssertNotNil(value, "Expected a Text, but found nil.")
        XCTAssertEqual("some text", value?.text)
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
        let widget: Widget? = try? sut.decode(from: jsonData)
        let anyWidget = widget as? AnyWidget
        let value = anyWidget?.value as? Unknown

        // Then
        XCTAssertEqual("beagle:widget:unknown", value?.type)
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
