//
//  SelectViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SelectViewEntityTests: XCTestCase {
 
    func test_whenMapToWidgetIsCalled_thenItShouldReturnASelectView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let rows = [WidgetEntityContainer(type: "Text", content: textEntity)]
        let sut = SelectViewEntity(rowsContainer: rows, remoteDataSource: nil, loadingStateContainer: nil)

        // When
        let selectView = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(selectView, "The SelectView widget should not be nil.")
        XCTAssertTrue(selectView is SelectView)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "type": "beagle:SelectView",
                "rows": [
                    {
                        "type": "beagle:Text",
                        "text": "some text"
                    }
                ],
                "remoteDataSource": "someDataSource.com/thingy",
                "loadingState": {
                    "type": "beagle:Text",
                    "text": "some text"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        let expectedRemoteDataSource = "someDataSource.com/thingy"

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: SelectView.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.rows.count, 1, "Expected 1, but found \(object?.rows.count ?? 0).")
        XCTAssertEqual(object?.rows.count, 1, "Expected 1, but found \(object?.rows.count ?? 0).")
        XCTAssertEqual(object?.remoteDataSource, expectedRemoteDataSource, "Expected \(expectedRemoteDataSource), but found \(object?.remoteDataSource ?? "nil").")
        XCTAssertNotNil(object?.loadingState, "Expected a loadingState, but found nil.")
        XCTAssertTrue(object?.loadingState is Text)
    }

}
