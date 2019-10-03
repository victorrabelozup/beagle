//
//  DropDownTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class DropDownTests: XCTestCase {

    func test_initWithBuilders_shouldReturnExpectedInstance() {
        // Given / When
        let widget = DropDown(
            header: {
                Text("text")
            },
            child: {
                Text("text")
            }
        )

        // Then
        XCTAssertTrue(widget.header is Text, "Expected `header` to be `Text`")
        XCTAssertTrue(widget.child is Text, "Expected `header` to be `Text`")
    }

}
