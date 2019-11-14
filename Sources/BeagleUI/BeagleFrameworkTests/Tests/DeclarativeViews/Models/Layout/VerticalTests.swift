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
    
    func test_whenNewClosureWithSingleChildWidget_shouldInitializeChild() {
        // Given
        let widget = Vertical.new { () -> Widget in
            return Text("coisa")
        }
        // When/ Then
        XCTAssert(widget.children.count == 1, "Expected widget to have only one children, but it has \(widget.children.count).")
        XCTAssert(widget.children.first is Text, "Expected child to be a Text widget, but it is \(String(describing: type(of: widget.children.first))).")
    }
    
    func test_whenNewClosureWithChildrenWidget_shouldInitializeChildren() {
        // Given
        let widget = Vertical.new { () -> [Widget] in
            return [Text("coisa"), Text("coisa 2")]
        }
        // When/ Then
        XCTAssert(widget.children.count > 1, "Expected widget to have more than one children, but it has \(widget.children.count).")
        XCTAssert(widget.children.last is Text, "Expected last child to be a Text widget, but it is \(String(describing: type(of: widget.children.last))).")
    }
}
