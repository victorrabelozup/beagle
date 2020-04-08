/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
            dependencies: BeagleDependencies()
        )
        
        // Then
        XCTAssertTrue(rootView is UITextView, "Expected a `UITextView`, but got \(String(describing: rootView)).")
    }
}
