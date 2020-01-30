//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigatorTests: XCTestCase {
    
    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Navigator(
            action: Navigate(type: .popView),
            child: Text("text")
        )

        // Then
        XCTAssert(widget.action.type == .popView)
        XCTAssertNil(widget.action.path)
        XCTAssertNil(widget.action.data)
        XCTAssert(widget.child is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let navigator = Navigator(action: Navigate(type: .popView), child: WidgetDummy())

        // When
        let view = navigator.toView(context: BeagleContextDummy(), dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(view is DummyView)
    }
}
