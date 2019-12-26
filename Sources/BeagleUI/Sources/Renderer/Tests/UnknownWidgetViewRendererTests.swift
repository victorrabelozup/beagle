//
//  Copyright © 14/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class UnknownWidgetViewRendererTests: XCTestCase {
    
    func test_initUnknownWidgetView_shouldConfigureALabelWithTheRightParameters() {
        // Given
        let renderer = UnknownWidgetViewRenderer(widget: WidgetDummy())
        let context = BeagleContextDummy()
        
        // When
        let view = renderer.buildView(context: context)
        
        // Then
        XCTAssert(view === renderer.label)
    }
}
