/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import XCTest
import UIKit
@testable import BeagleUI

final class NSObjectExtensionTests: XCTestCase {
    
    func test_className_shouldReturnValidName() {
        // Given
        let expectedName = "MockTableViewClass"
        
        // When
        let sut = MockTableViewClass.className
        
        // Then
        XCTAssertEqual(expectedName, sut, "The names should be as expected.")
    }
    
}

private class MockTableViewClass: UITableView {}
