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
        let flex = FlexEntity.fixture()
        let sut = VerticalEntity(childrenContainer: children, flex: flex, reversed: false)

        // When
        let vertical = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(vertical, "The Vertical widget should not be nil.")
        XCTAssertTrue(vertical is Vertical)
    }
    
//    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
//        // Given
//        let json = """
//            {
//                "type": "beagle:Vertical",
//                "children": [
//                    {
//                        "type": "beagle:Text",
//                        "text": "some text"
//                    }
//                ],
//                "flex": {
//                  "justifyContent": "SPACE_BETWEEN"
//                },
//                "reversed": true
//            }
//        """
//        guard let jsonData = json.data(using: .utf8) else {
//            XCTFail("Could not create JSON data.")
//            return
//        }
//        let expectedRemoteDataSource = "someDataSource.com/thingy"
//
//        // When
//        let object = try? WidgetDecoder().decodeToWidget(ofType: Vertical.self, from: jsonData)
//
//        // Then
//        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
//        XCTAssertEqual(object?.children.count, 1, "Expected 1, but found \(object?.children?.count ?? 0).")
//        XCTAssertEqual(object?.remoteDataSource, expectedRemoteDataSource, "Expected \(expectedRemoteDataSource), but found \(object?.remoteDataSource ?? "nil").")
//        XCTAssertNotNil(object?.loadingState, "Expected a loadingState, but found nil.")
//        XCTAssertTrue(object?.loadingState is Text)
//        if case let direction = object?.direction, direction != ListView.Direction.vertical {
//            XCTFail("Invalid direction.")
//        }
//
//    }
    
}
