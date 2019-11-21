//
//  ScrollViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Tarcisio Clemente on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScrollViewEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAScrollViewWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:widget:flexWidget", content: content)]
        let sut = ScrollViewEntity(childrenContainer: children, reversed: false)

        // When
        let scrollView = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(scrollView, "The ScrollView widget should not be nil.")
        XCTAssertTrue(scrollView is ScrollView)
    }

    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:scrollview",
                "children": [
                  {
                      "_beagleType_": "beagle:widget:flexWidget",
                      "flex": {
                          "alignItems": "CENTER"
                      },
                      "children": [
                          {
                              "_beagleType_": "beagle:widget:text",
                              "text": "TESTE"
                          }
                      ]
                  }
                ]
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: ScrollView.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertTrue(object?.children.first is FlexWidget)
    }
    
}
