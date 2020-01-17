//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ScrollViewTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScrollView(children: [
            Text("text")
        ])
        
        // Then
        XCTAssertEqual(widget.children.count, 1)
        XCTAssertTrue(widget.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScrollView(children: [
            Text("text"),
            Button(text: "text")
        ])
        
        // Then
        XCTAssert(widget.children.count == 2)
        XCTAssert(widget.children[safe: 0] is Text)
        XCTAssert(widget.children[safe: 1] is Button)
    }
    
    func test_whenDecodingJson_shouldReturnAScrollView() throws {
        let widget: ScrollView = try widgetFromJsonFile(fileName: "ScrollViewWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexWidget() throws {
        let widget: ScrollView = try widgetFromJsonFile(fileName: "ScrollViewWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget))
        )
        assertSnapshotImage(screen)
    }

}
