//
//  Copyright © 20/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigationBarTests: XCTestCase {

    func testLeadingAndTrailing() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            leading: Button(text: "Button"),
            trailing: Button(text: "Button2")
        )
        // Then
        XCTAssert(widget.leading is Button)
        XCTAssert(widget.trailing is Button)
    }
    
    func testLeadingOnly() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            leading: Button(text: "Button")
        )
        // Then
        XCTAssert(widget.leading is Button)
    }
    
    func testTrailingOnly() {
        // Given / When
        let widget = NavigationBar(
            title: "Teste",
            trailing: Button(text: "Button2")
        )
        // Then
        XCTAssert(widget.trailing is Button)
    }

}
