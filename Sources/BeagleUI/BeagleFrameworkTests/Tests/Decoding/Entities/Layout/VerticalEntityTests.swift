//
//  VerticalEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class VerticalEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAVerticalWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:Text", content: content)]
        let flex = FlexEntity()
        let sut = VerticalEntity(childrenContainer: children, flex: flex, reversed: false)

        // When
        let vertical = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(vertical, "The Vertical widget should not be nil.")
        XCTAssertTrue(vertical is Vertical)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObjectWithDefaultValues() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:vertical",
                "children": [
                    {
                        "_beagleType_": "beagle:widget:text",
                        "text": "some text"
                    }
                ]
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: Vertical.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.children.count, 1, "Expected 1, but found \(object?.children.count ?? 0).")
        XCTAssertTrue(object?.reversed == false, "Expected `false`, but got false.")
    }
    
}
