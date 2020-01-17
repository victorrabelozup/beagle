//
//  StackTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 03/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class StackTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Stack(children: [
            Text("text")
        ])

        // Then
        XCTAssert(widget.children.count == 1)
        XCTAssert(widget.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Stack(children: [
            Text("text"),
            Button(text: "text")
        ])

        // Then
        XCTAssert(widget.children.count == 2)
        XCTAssert(widget.children[safe: 0] is Text)
        XCTAssert(widget.children[safe: 1] is Button)
    }

}
