//
//  LazyWidgetTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyWidgetTests: XCTestCase {
    
    func test_initWithInitialStateBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let sut = LazyWidget(url: "widget") {
            Text("text")
        }

        // Then
        XCTAssertEqual(sut.url, "widget")
        XCTAssertTrue(sut.initialState is Text)
    }
}
