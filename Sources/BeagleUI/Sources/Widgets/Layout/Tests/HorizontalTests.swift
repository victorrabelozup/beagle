//
//  Copyright © 02/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class HorizontalTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Horizontal(children: [
            Text("text")
        ])

        // Then
        XCTAssert(widget.children.count == 1)
        XCTAssert(widget.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Horizontal(children: [
            Text("text"),
            Button(text: "text")
        ])

        // Then
        XCTAssert(widget.children.count == 2)
        XCTAssert(widget.children[safe: 0] is Text)
        XCTAssert(widget.children[safe: 1] is Button)
    }
    
    func test_callingReversed_shouldChangeItsValue() {
        // Given
        let widget = Horizontal(children: [
            Text("text")
        ])
        
        // When
        let updatedWidget = widget.reversed()
        
        // Then
        XCTAssert(widget.reversed != updatedWidget.reversed)
    }

}
