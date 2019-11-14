//
//  FlexWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFlexWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:widget:text", content: content)]
        let flex = FlexEntity()
        let sut = FlexWidgetEntity(childrenContainer: children, flex: flex)
        
        // When
        let flexWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexWidget, "Flex widget should not be nil.")
        XCTAssertTrue(flexWidget is FlexWidget)
    }
    
    func test_whenDecodingAValidJson_itShouldReturnAValidObject() {
        let json = """
            {
                "_beagleType_": "beagle:widget:flexwidget",
                "children": [
                    {
                        "_beagleType_": "beagle:widget:text",
                        "text": "some text"
                    }
                ],
                "justifyContent": "CENTER"
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: FlexWidget.self, from: jsonData)
        guard let childrenCount = object?.children.count else {
            XCTFail("Could not find children.")
            return
        }
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertTrue(childrenCount > 0, "Expected object to have children.")
    }
    
}
