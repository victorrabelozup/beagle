//
//  ScrollViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Tarcisio Clemente on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScrollViewEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAScrollViewWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [AnyDecodableContainer(content: content)]
        let sut = ScrollViewEntity(children: children)

        // When
        let scrollView = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(scrollView, "The ScrollView widget should not be nil.")
        XCTAssertTrue(scrollView is ScrollView)
    }
}
