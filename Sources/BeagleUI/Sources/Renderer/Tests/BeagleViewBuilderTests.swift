//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleViewBuilderTests: XCTestCase {

    func test_buildFromRootComponent_shouldReturnTheExpectedRootView() {
        // Given
        let component = Text("Text")
        let context = BeagleContextDummy()
        
        // When
        let rootView = component.toView(
            context: context,
            dependencies: BeagleDependencies(appName: "TEST")
        )
        
        // Then
        XCTAssertTrue(rootView is UILabel, "Expected a `UILabel`, but got \(String(describing: rootView)).")
    }
}
