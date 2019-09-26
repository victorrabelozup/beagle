//
//  PaddingEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class PaddingEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAPaddingWidget() {
        // Given
        let content = TextEntity(text: "text")
        let value = PaddingValueEntity(top: nil, left: nil, right: nil, bottom: nil)
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        guard let sut = try? PaddingEntity(value: value, childContainer: child) else {
            XCTFail("Could not create PaddingEntity.")
            return
        }

        // When
        let padding = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(padding, "The Padding widget should not be nil.")
        XCTAssertTrue(padding is Padding)
    }

    func test_whenWidgetEntityContainerIsCreatedWithNoChildContent_thenItShouldThrowAnError() {
        // Given
        let value = PaddingValueEntity(top: nil, left: nil, right: nil, bottom: nil)
        let child = WidgetEntityContainer(type: "beagle:Text", content: nil)
        
        // When/Then
        XCTAssertThrowsError(
            _ = try PaddingEntity(value: value, childContainer: child),
            "Expected to Throw an error, but it didn't."
        )
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "type": "beagle:Padding",
                "child": {
                    "type": "beagle:Text",
                    "text": "some text"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: Padding.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.value.bottom, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.value.left, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.value.right, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.value.top, "Expected a valid object, but found nil.")
    }
    
}
