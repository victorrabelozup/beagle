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
    
    func test_whenMapToWidgetIsCalledOnVerticalListViewEntity_thenItShouldReturnAVerticalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let textRows = [AnyDecodableContainer(content: textEntity)]
        let verticalEntity = VerticalEntity(children: textRows, reversed: false)
        let rows = [AnyDecodableContainer(content: verticalEntity)]
        let sut = ListViewEntity(rows: rows, remoteDataSource: nil, loadingState: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
    func test_whenMapToWidgetIsCalledOnHorizontalListViewEntity_thenItShouldReturnAHorizontalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let textRows = [AnyDecodableContainer(content: textEntity)]
        let horizontalEntity = HorizontalEntity(children: textRows, reversed: false)
        let rows = [AnyDecodableContainer(content: horizontalEntity)]
        let sut = ListViewEntity(rows: rows, remoteDataSource: nil, loadingState: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
}
