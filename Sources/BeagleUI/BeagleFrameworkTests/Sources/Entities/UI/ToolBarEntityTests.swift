//
//  ToolBarEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ToolBarEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAToolBar() {
        // Given
        let sut = ToolBarEntity(title: "text")
        
        // When
        let toolBar = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(toolBar, "The ToolBar widget should not be nil.")
        XCTAssertTrue(toolBar is ToolBar)
    }

}
