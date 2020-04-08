/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
