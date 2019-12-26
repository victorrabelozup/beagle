//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleViewBuilderTests: XCTestCase {

    func test_buildFromRootWidget_shouldReturnTheExpectedRootView() {
        // Given
        let widget = Text("Text")
        let context = BeagleContextDummy()
        
        // When
        let rootView = widget.toView(
            context: context,
            dependencies: BeagleDependencies(appName: "TEST")
        )
        
        // Then
        XCTAssertTrue(rootView is UILabel, "Expected a `UILabel`, but got \(String(describing: rootView)).")
    }
}
