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

}
