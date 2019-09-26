//
//  DropDownEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class DropDownEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnADropDown() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: content)
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        let sut = try? DropDownEntity(headerContainer: header, childContainer: child)

        // When
        let dropDown = try? sut?.mapToWidget()

        // Then
        XCTAssertNotNil(dropDown, "The DropDown widget should not be nil.")
        XCTAssertTrue(dropDown is DropDown)
    }

    func test_whenInitIsCalledWithInvalidHeaderContent_thenItShouldThrowAHeaderError() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: nil)
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)

        // When / Then
        XCTAssertThrowsError(
            _ = try DropDownEntity(headerContainer: header, childContainer: child),
            "Expected to Throw an error, but it didn't."
        )
    }

    func test_whenInitIsCalledWithInvalidChildContent_thenItShouldThrowAChildError() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: content)
        let child = WidgetEntityContainer(type: "beagle:Text", content: nil)

        // When / Then
        XCTAssertThrowsError(
            _ = try DropDownEntity(headerContainer: header, childContainer: child),
            "Expected to Throw an error, but it didn't."
        )
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "type": "beagle:DropDown",
                "header": {
                    "type": "beagle:Text",
                    "text": "some text"
                },
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
        let object = try? WidgetDecoder().decodeToWidget(ofType: DropDown.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertTrue(object?.header is Text)
        XCTAssertTrue(object?.child is Text)
    }

}
