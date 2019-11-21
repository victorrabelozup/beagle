//
//  NavigationBarEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigationBarEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnANavigationBar() {
        // Given
        let leading = ButtonEntity(text: "Left")
        let trailing = ButtonEntity(text: "Right")
        let leadingMock = WidgetEntityContainer(type: "beagle:Button", content: leading)
        let trailingMock = WidgetEntityContainer(type: "beagle:Button", content: trailing)
        guard let sut = try? NavigationBarEntity(title: "Iti", leadingWidget: leadingMock, trailingWidget: trailingMock) else {
            XCTFail("Could not create NavigationBar Entity.")
            return
        }
        // When
        let navigationBar = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(navigationBar, "The NavigationBar widget should not be nil.")
        XCTAssertTrue(navigationBar is NavigationBar)
    }
    
    func test_whenWidgetEntityContainerIsCreatedWithNoLeadingContent_thenItShouldThrowAnError() {
        // Given
        let title = "Teste"
        let leading = ButtonEntity(text: "Right")
        let trailing = WidgetEntityContainer(type: "beagle:Text", content: nil)
        let leadingMock = WidgetEntityContainer(type: "beagle:Button", content: leading)

        
        // When/Then
        XCTAssertThrowsError(
            _ = try NavigationBarEntity(title: title, leadingWidget: leadingMock, trailingWidget: trailing),
            "Expected to Throw an error, but it didn't."
        )
    }

    func test_whenWidgetEntityContainerIsCreatedWithNoTrailingContent_thenItShouldThrowAnError() {
        // Given
        let leading = WidgetEntityContainer(type: "beagle:Text", content: nil)
        let trailing = ButtonEntity(text: "Right")
        let trailingMock = WidgetEntityContainer(type: "beagle:Button", content: trailing)

        
        // When/Then
        XCTAssertThrowsError(
            _ = try NavigationBarEntity(title: nil, leadingWidget: leading, trailingWidget: trailingMock),
            "Expected to Throw an error, but it didn't."
        )
    }

    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:NavigationBar",
                "title": "Title",
                "leading": {
                    "_beagleType_": "beagle:widget:text",
                    "text": "some text"
                },
                "trailing": {
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
        let object = try? WidgetDecoder().decodeToWidget(ofType: NavigationBar.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.leading, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.trailing, "Expected a valid object, but found nil.")
    }

}



