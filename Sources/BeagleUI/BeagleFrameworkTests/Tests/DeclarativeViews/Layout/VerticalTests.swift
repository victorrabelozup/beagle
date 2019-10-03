//
//  VerticalTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 03/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class VerticalTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Vertical {
            Text("text")
        }

        // Then
        XCTAssertEqual(widget.children.count, 1, "Expected `children.count` to be `1`.")
        XCTAssertTrue(widget.children[safe: 0] is Text, "Expected to find `Text`.")
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Vertical {
            Text("text")
            Button(text: "text")
        }

        // Then
        XCTAssertEqual(widget.children.count, 2, "Expected `children.count` to be `2`.")
        XCTAssertTrue(widget.children[safe: 0] is Text, "Expected to find `Text`.")
        XCTAssertTrue(widget.children[safe: 1] is Button, "Expected to find `Button`.")
    }
    
    func test_callingReversed_shouldChangeItsValue() {
        // Given
        let widget = Vertical {
            Text("text")
        }
        
        // When
        let updatedWidget = widget.reversed()
        
        // Then
        XCTAssertNotEqual(widget.reversed, updatedWidget.reversed, "Expected `reversed` to be diferent from initial value.")
    }

}
