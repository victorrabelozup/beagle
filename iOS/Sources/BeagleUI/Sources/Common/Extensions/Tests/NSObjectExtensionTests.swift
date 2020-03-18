//
//  NSObjectExtensionTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

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
