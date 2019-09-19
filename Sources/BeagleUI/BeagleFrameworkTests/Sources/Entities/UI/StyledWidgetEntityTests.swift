//
//  StyledWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class StyledWidgetEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAStyledWidget() {
        // Given
        let sut = StyledWidgetEntity(border: nil, color: nil, child: nil)
        
        // When
        let styledWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(styledWidget, "The StyledWidget widget should not be nil.")
        XCTAssertTrue(styledWidget is StyledWidget)
    }

}
