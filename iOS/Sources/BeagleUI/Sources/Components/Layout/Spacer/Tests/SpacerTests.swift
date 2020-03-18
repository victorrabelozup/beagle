//
//  Copyright © 29/01/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SpacerTests: XCTestCase {
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let dependencies = BeagleScreenDependencies()
        let spacer = Spacer(1.0)
    
        // When
        let view = spacer.toView(context: BeagleContextDummy(), dependencies: dependencies)
        view.backgroundColor = .blue

        // Then
        assertSnapshotImage(view, size: CGSize(width: 100, height: 100))
    }

    // TODO: make a test that actually hava a space with something else
}
