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

}
