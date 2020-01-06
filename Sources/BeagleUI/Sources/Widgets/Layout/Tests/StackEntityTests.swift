//
//  StackEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class StackEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAStackWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [AnyDecodableContainer(content: content)]
        let sut = StackEntity(appearance: nil, children: children)

        // When
        let stack = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(stack, "The Stack widget should not be nil.")
        XCTAssertTrue(stack is Stack)
    }
}
