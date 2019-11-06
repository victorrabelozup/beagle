//
//  StackEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class StackEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAStackWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:Text", content: content)]
        let sut = StackEntity(childrenContainer: children)

        // When
        let stack = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(stack, "The Stack widget should not be nil.")
        XCTAssertTrue(stack is Stack)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:stack",
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
        let object = try? WidgetDecoder().decodeToWidget(ofType: Stack.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.children.count, 1, "Expected 1, but found \(object?.children.count ?? 0).")
    }
    
}
