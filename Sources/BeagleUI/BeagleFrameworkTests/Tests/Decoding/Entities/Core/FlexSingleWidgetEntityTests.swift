//
//  FlexSingleWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexSingleWidgetEntityTests: XCTestCase {
    
    func test_whenDecodingAValidJson_itShouldReturnAValidObject() {
        let json = """
            {
                "type": "beagle:FlexSingleWidget",
                "child": {
                        "type": "beagle:Text",
                        "text": "Some Text"
                    },
                "justifyContent": "CENTER"
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: FlexSingleWidget.self, from: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.child, "Expected object to have a single child, but found nil.")
    }
    
    func test_whenDecodingAInvalidJson_itShouldThrowDecodingError() {
        // Given
        let child = WidgetEntityContainer(type: "beagle:Text", content: nil)

        // When /Then
        XCTAssertThrowsError(_ = try FlexSingleWidgetEntity(childContainer: child, flex: nil), "Expected to throw an error, but got none.") { error in
                XCTAssertTrue(error is WidgetDecodingError, "Expected a `WidgetDecodingError`, but got \(error.localizedDescription).")
        }
    }
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFlexSingleWidget() {
        // Given
        let content = TextEntity(text: "Some text")
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        let flex = FlexEntity.fixture()
        guard let sut = try? FlexSingleWidgetEntity(childContainer: child, flex: flex) else {
            XCTFail("Could not create Flex single widget.")
            return
        }
        
        // When
        let flexSingleWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexSingleWidget, "Flex widget should not be nil.")
        XCTAssertTrue(flexSingleWidget is FlexSingleWidget)
    }
}
