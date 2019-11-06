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
            headerContainer: containerMock,
            contentContainer: containerMock,
            footerContainer: containerMock
        ) else {
            XCTFail("Could not create ContainerEntity.")
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
        XCTAssertThrowsError(_ = try ContainerEntity(headerContainer: nil, contentContainer: containerMock, footerContainer: nil), "Expected to throw an error, but got none.") { error in
            XCTAssertTrue(error is WidgetDecodingError, "Expected a `WidgetDecodingError`, but got \(error.localizedDescription).")
        }
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:container",
                "header": {
                    "_beagleType_": "beagle:widget:text",
                    "text": "some text"
                },
                "content": {
                     "_beagleType_": "beagle:widget:text",
                     "text": "some text"
                },
                "footer": {
                     "_beagleType_": "beagle:widget:text",
                     "text": "some text"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: Container.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertTrue(object?.header is Text)
        XCTAssertTrue(object?.content is Text)
        XCTAssertTrue(object?.footer is Text)
    }
}
