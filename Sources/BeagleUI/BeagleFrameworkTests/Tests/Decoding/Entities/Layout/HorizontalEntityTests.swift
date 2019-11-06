//
//  HorizontalEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class HorizontalEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAHorizontalWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:Text", content: content)]
        let flex = FlexEntity()
        let sut = HorizontalEntity(childrenContainer: children, flex: flex, reversed: false)

        // When
        let horizontal = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(horizontal, "The Horizontal widget should not be nil.")
        XCTAssertTrue(horizontal is Horizontal)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObjectWithDefaultValues() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:horizontal",
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
        let object = try? WidgetDecoder().decodeToWidget(ofType: Horizontal.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.children.count, 1, "Expected 1, but found ")
        XCTAssertTrue(object?.reversed == false, "Expected `false`, but got false.")
    }

}
