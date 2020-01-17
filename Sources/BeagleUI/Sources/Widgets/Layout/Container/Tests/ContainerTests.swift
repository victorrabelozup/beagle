//
//  ContainerTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerTests: XCTestCase {

    func test_initWithBuilders_shouldReturnExpectedInstance() {
        // Given / When
        let widget = Container(
            header: Text("text"),
            content: Text("text"),
            footer: Text("text")
        )

        // Then
        XCTAssertTrue(widget.header is Text, "Expected `header` to be `Text`")
        XCTAssertTrue(widget.content is Text, "Expected `header` to be `Text`")
        XCTAssertTrue(widget.footer is Text, "Expected `header` to be `Text`")
    }

}
