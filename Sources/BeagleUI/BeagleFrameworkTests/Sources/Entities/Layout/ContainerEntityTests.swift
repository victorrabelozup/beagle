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
        let containerMock = WidgetEntityContainer(type: "beagle:Text", content: innerContent)
        guard let sut = try? ContainerEntity(
            bodyContainer: containerMock,
            contentContainer: containerMock,
            footerContainer: containerMock
        ) else {
            XCTFail("Could not create PaddingEntity.")
            return
        }

        // When
        let container = try? sut.mapToWidget()

        // Then
        XCTAssertNotNil(container, "The Container widget should not be nil.")
        XCTAssertTrue(container is Container)
    }

    func test_whenWidgetEntityContainerIsCreatedWithNoChildContent_thenItShouldThrowAnError() {
        // Given
        let containerMock = WidgetEntityContainer(type: "beagle:Text", content: nil)

        // When/Then
        XCTAssertThrowsError(
            _ = try ContainerEntity(
                bodyContainer: nil,
                contentContainer: containerMock,
                footerContainer: nil
            ),
            "Expected to Throw an error, but it didn't."
        )
    }
    
}
