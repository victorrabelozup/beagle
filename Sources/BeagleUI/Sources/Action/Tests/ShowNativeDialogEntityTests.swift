//
//  ShowNativeDialogEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ShowNativeDialogEntityTests: XCTestCase {
    
    func test_whenMapToActionIsCalled_thenItShouldReturnAShowNativeDialog() {
        // Given
        let sut = ShowNativeDialogEntity(title: "title", message: "message", buttonText: "button")
        
        // When
        guard let action = try? sut.mapToAction() else {
            XCTFail("Could not create ShowNativeDialog Model.")
            return
        }
        let showNativeDialog = action as? ShowNativeDialog

        // Then
        XCTAssertNotNil(showNativeDialog)
        XCTAssertEqual(showNativeDialog?.title, "title")
        XCTAssertEqual(showNativeDialog?.message, "message")
        XCTAssertEqual(showNativeDialog?.buttonText, "button")
    }
    
}
