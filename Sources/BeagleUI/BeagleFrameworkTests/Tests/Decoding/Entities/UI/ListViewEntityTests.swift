//
//  ListViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 15/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewEntityTests: XCTestCase {
    
    func test_whenDecodingValidJson_thenItShouldReturnAListView() {
        // Given
        let json = """
            {
                "type": "beagle:ListView",
                "rows": [
                    {
                        "type": "beagle:Text",
                        "text": "some text"
                    }
                ],
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
        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: ListView.self, from: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.rows?.count, 1, "Expected 1, but found \(object?.rows?.count ?? 0).")
    }
    
    func test_whenMapToWidgetIsCalledOnVerticalListViewEntity_thenItShouldReturnAVerticalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let textRows = [WidgetEntityContainer(type: "Text", content: textEntity)]
        let verticalEntity = VerticalEntity(childrenContainer: textRows, flex: .init(), reversed: false)
        let rows = [WidgetEntityContainer(type: "Vertical", content: verticalEntity)]
        let sut = ListViewEntity(rowsContainer: rows, remoteDataSource: nil, loadingStateContainer: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
    func test_whenMapToWidgetIsCalledOnHorizontalListViewEntity_thenItShouldReturnAHorizontalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let textRows = [WidgetEntityContainer(type: "Text", content: textEntity)]
        let horizontalEntity = HorizontalEntity(childrenContainer: textRows, flex: .init(), reversed: false)
        let rows = [WidgetEntityContainer(type: "Horizontal", content: horizontalEntity)]
        let sut = ListViewEntity(rowsContainer: rows, remoteDataSource: nil, loadingStateContainer: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
}
