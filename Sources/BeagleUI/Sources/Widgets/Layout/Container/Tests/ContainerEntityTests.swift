//
//  ContainerEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAContainerWidget() {
        // Given
        let innerContent = TextEntity(text: "text")
        let containerMock = AnyDecodableContainer(content: innerContent)
        let sut = ContainerEntity(
            header: containerMock,
            content: containerMock,
            footer: containerMock
        )

        // When
        let container = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(container, "The Container widget should not be nil.")
        XCTAssertTrue(container is Container)
    }
}
