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

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAListView() {
        // Given
        let sut = ListViewEntity(rows: nil, remoteDataSource: nil, loadingState: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }

}
