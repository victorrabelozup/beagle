//
//  HorizontalEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class HorizontalEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAHorizontalWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:Text", content: content)]
        let flex = FlexEntity.fixture()
        let sut = HorizontalEntity(childrenContainer: children, flex: flex, reversed: false)

        // When
        let horizontal = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(horizontal, "The Horizontal widget should not be nil.")
        XCTAssertTrue(horizontal is Horizontal)
    }

}
