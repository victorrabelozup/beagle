//
//  CustomActionHandlerTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class CustomActionHandlerTests: XCTestCase {
    
    func test_whenHandleCustomAction_shouldCallHandler() {
        // Given
        let actionName = "action-name"
        let action = CustomAction(name: actionName, data: [:])
        let sut = CustomActionHandling()
        var didHandleActioin = false
        sut[actionName] = { _, _ in
            didHandleActioin = true
        }
        
        // When
        sut.handle(context: BeagleContextDummy(), action: action)
        
        // Then
        XCTAssertTrue(didHandleActioin)
    }
}
