//
//  StyledWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class StyledWidgetEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAStyledWidget() {
        // Given
        let border = BorderEntity(color: nil, radius: nil, size: nil)
        let childContainer = WidgetEntityContainer(type: "beagle:Text", content: TextEntity(text: "something"))
        guard let sut = try? StyledWidgetEntity(border: border, color: nil, childContainer: childContainer) else {
            XCTFail("Could not create `StyledWidgetEntity`.")
            return
        }

        // When
        let styledWidget = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(styledWidget, "The StyledWidget widget should not be nil.")
        XCTAssertTrue(styledWidget is StyledWidget)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "type": "beagle:StyledWidget",
                "border": {
                    "color": "white",
                    "radius": 1.0,
                    "size": 2.0
                },
                "color": "blue",
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
        let expectedWidgetBorder = Border(color: "white", radius: 1.0, size: 2.0)
        let expectedWidget = StyledWidget(
            border: expectedWidgetBorder,
            color: "blue",
            child: Text(text: "some text")
        )

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: StyledWidget.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.border?.color, expectedWidgetBorder.color, "Expected \(expectedWidgetBorder.color ?? "nil"), but found \(object?.border?.color ?? "nil").")
        XCTAssertEqual(object?.border?.radius, expectedWidgetBorder.radius, "Expected \(expectedWidgetBorder.radius.debugDescription), but found \(object?.border?.radius.debugDescription ?? "nil").")
        XCTAssertEqual(object?.border?.size, expectedWidgetBorder.size, "Expected \(expectedWidgetBorder.size.debugDescription), but found \(object?.border?.size.debugDescription ?? "nil").")
        XCTAssertEqual(object?.color, expectedWidget.color, "Expected \(object?.color ?? "nil"), but found \(expectedWidget.color ?? "nil").")
        XCTAssertNotNil(object?.child, "Expected a child, but found nil.")
        XCTAssertTrue(object?.child is Text)
    }
    
    func test_whenDecodingAValidJSONWithNoValidChild_itShouldReturnAnError() {
        // Given
        let json = """
            {
                "type": "beagle:StyledWidget",
                "border": {
                    "color": "white",
                    "radius": 1.0,
                    "size": 2.0
                },
                "color": "blue",
                "child": {
                    "type": "beagle:Invalid",
                    "value": "meh"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        var errorThrown: Error?
        do {
            _ = try WidgetDecoder().decodeToWidget(ofType: StyledWidget.self, from: jsonData)
        } catch {
            errorThrown = error
        }

        // Then
        XCTAssertNotNil(errorThrown, "Expected to capture an error, but got nil.")
        XCTAssertTrue(errorThrown is WidgetDecodingError, "Expected a `WidgetDecodingError`, but got \(errorThrown.debugDescription).")
    }
    
}
