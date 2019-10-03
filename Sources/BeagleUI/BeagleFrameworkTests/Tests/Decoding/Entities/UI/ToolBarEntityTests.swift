//
//  ToolBarEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ToolBarEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAToolBar() {
        // Given
        let sut = ToolBarEntity(title: "text", showBackButton: true)
        
        // When
        let toolBar = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(toolBar, "The ToolBar widget should not be nil.")
        XCTAssertTrue(toolBar is ToolBar)
    }
    
    func test_whenDecodingAValidJSON_itShouldReturnAValidObjectWithTheExpectedDefaults() {
        // Given
        let json = """
            {
                "type": "beagle:ToolBar",
                "title": "some bar"
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        let expectedTitle = "some bar"

        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: ToolBar.self, from: jsonData)

        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.title, expectedTitle, "Expected \(expectedTitle), but found \(object?.title ?? "`nil`").")
        let showBackButtonDefaultIsCorrect = object?.showBackButton == true
        XCTAssertTrue(showBackButtonDefaultIsCorrect, "Expected `true`, but found false.")
    }

}
