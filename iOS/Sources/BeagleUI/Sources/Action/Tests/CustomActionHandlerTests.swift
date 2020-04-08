/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class CustomActionHandlerTests: XCTestCase {
    
    func test_whenHandleCustomAction_shouldCallHandler() {
        // Given
        let actionName = "action-name"
        let action = CustomAction(name: actionName, data: [:])
        let sut = CustomActionHandling()
        var didHandleActioin = false
        sut[actionName] = { _, _, _ in
            didHandleActioin = true
        }
        
        // When
        sut.handle(context: BeagleContextDummy(), action: action) { _ in }
        
        // Then
        XCTAssertTrue(didHandleActioin)
    }
}
