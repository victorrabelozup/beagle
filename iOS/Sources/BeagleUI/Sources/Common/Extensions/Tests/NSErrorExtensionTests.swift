/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

@testable import BeagleUI
import XCTest

final class NSErrorExtensionTests: XCTestCase {
    
    func test_initNSErrorWithDescription() {
        // Given
        let description = "Some description"
        
        // When
        let error = NSError(domain: "NSErrorExtensionTests", code: -1, description: description)
        
        // Then
        XCTAssertEqual(error.localizedDescription, description, "The descriptions are different, when they should be the same.")
    }
    
}
