//
//  Copyright © 14/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class UnknownComponentTests: XCTestCase {
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let component = UnknownComponent(type: String(describing: ComponentDummy()))
        
        // When
        let view = component.toView(context: BeagleContextDummy(), dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(view is UILabel)
        XCTAssertEqual((view as? UILabel)?.text, "Unknown Component of type:\nComponentDummy()")
    }
}
