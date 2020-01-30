//
//  Copyright © 14/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class AnyWidgetTests: XCTestCase {
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let widget = AnyWidget(value: WidgetDummy())
        
        // When
        let view = widget.toView(context: BeagleContextDummy(), dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(view is UILabel)
        XCTAssertEqual((view as? UILabel)?.text, "Unknown Widget of type:\n WidgetDummy()")
    }
}
