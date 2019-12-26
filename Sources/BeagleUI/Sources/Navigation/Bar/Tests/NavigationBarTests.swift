//
//  Copyright © 20/11/19 Zup IT. All rights reserved.
//

// swiftlint:disable trailing_closure

import XCTest
@testable import BeagleUI

final class NavigationBarTests: XCTestCase {

    func test_initWithLeadingAndTrailing_shouldReturnExpectedInstance() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            leading: {
                Button(text: "Button")
            },
            trailing: {
                Button(text: "Button2")
            }
        )
        // Then
        XCTAssertTrue(widget.leading is Button, "Expected to find `Button`.")
        XCTAssertTrue(widget.trailing is Button, "Expected to find `Button`.")
    }
    
    func test_initWithLeadingOnly_shouldReturnExpectedInstance() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            leading: {
                Button(text: "Button")
            }
        )
        // Then
        XCTAssertTrue(widget.leading is Button, "Expected to find `Button`.")
    }
    
    func test_initWithTrailingOnly_shouldReturnExpectedInstance() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            trailing: {
                Button(text: "Button2")
            }
        )
        // Then
        XCTAssertTrue(widget.trailing is Button, "Expected to find `Button`.")
    }

}
