//
//  ListViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalledOnVerticalListViewEntity_thenItShouldReturnAVerticalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let rows = [WidgetEntityContainer(type: "Text", content: textEntity)]
        let sut = ListViewEntity(
            rowsContainer: rows,
            remoteDataSource: nil,
            loadingStateContainer: nil,
            direction: .vertical
        )

        // When
        let listView = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }

    func test_whenMapToWidgetIsCalledOnHorizontalListViewEntity_thenItShouldReturnAHorizontalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let rows = [WidgetEntityContainer(type: "Text", content: textEntity)]
        let sut = ListViewEntity(
            rowsContainer: rows,
            remoteDataSource: nil,
            loadingStateContainer: nil,
            direction: .horizontal
        )

        // When
        let listView = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
//    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
//        // Given
//        let json = """
//            {
//                "type": "beagle:ListView",
//                "rows": [
//                    {
//                        "type": "beagle:Vertical"
//                        "children": [
//                            {
//                                "type": "beagle:Text",
//                                "text": "some text"
//                            }
//                        ]
//                    }
//                ],
//                "remoteDataSource": "someDataSource.com/thingy",
//                "loadingState": {
//                    "type": "beagle:Text",
//                    "text": "some text"
//                },
//                "direction": "vertical"
//            }
//        """
//        guard let jsonData = json.data(using: .utf8) else {
//            XCTFail("Could not create JSON data.")
//            return
//        }
//        let expectedRemoteDataSource = "someDataSource.com/thingy"
//
//        // When
//        let object = try? WidgetDecoder().decodeToWidget(ofType: ListView.self, from: jsonData)
//
//        // Then
//        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
//        XCTAssertEqual(object?.rows?.count, 1, "Expected 1, but found \(object?.rows?.count ?? 0).")
//        XCTAssertEqual(object?.rows?.count, 1, "Expected 1, but found \(object?.rows?.count ?? 0).")
//        XCTAssertEqual(object?.remoteDataSource, expectedRemoteDataSource, "Expected \(expectedRemoteDataSource), but found \(object?.remoteDataSource ?? "nil").")
//        XCTAssertNotNil(object?.loadingState, "Expected a loadingState, but found nil.")
//        XCTAssertTrue(object?.loadingState is Text)
//        if case let direction = object?.direction, direction != ListView.Direction.vertical {
//            XCTFail("Invalid direction.")
//        }
//
//    }

}
