//
//  NavigationBarTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 20/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigationBarTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = NavigationBar(title: "Teste", leading: {
            Button(text: "Button")
        }, trailing: {
            Button(text: "Button2")
        })
        // Then
        XCTAssertTrue(widget.leading is Button, "Expected to find `Button`.")
        XCTAssertTrue(widget.trailing is Button, "Expected to find `Button`.")
    }
}
