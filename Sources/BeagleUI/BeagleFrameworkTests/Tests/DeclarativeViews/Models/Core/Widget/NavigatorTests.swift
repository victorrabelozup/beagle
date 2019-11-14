//
//  NavigatorTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigatorTests: XCTestCase {
    
    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Navigator(action: Navigate(type: .popView)) {
            Text("text")
        }

        // Then
        XCTAssertEqual(widget.action.type, .popView, "Expected `action.type` to be `.popView`")
        XCTAssertNil(widget.action.path, "Expected `action.path` to be nil")
        XCTAssertNil(widget.action.data, "Expected `action.data` to be nil")
        XCTAssertTrue(widget.child is Text, "Expected to find `Text`.")
    }
}
