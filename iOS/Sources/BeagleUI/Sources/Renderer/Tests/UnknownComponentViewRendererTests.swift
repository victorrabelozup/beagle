/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
        XCTAssertEqual((view as? UILabel)?.text, "Unknown Component of type:\n ComponentDummy()")
    }
}
