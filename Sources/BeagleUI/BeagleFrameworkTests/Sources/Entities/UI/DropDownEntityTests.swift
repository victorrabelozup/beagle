//
//  DropDownEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class DropDownEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnADropDown() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: content)
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        let sut = DropDownEntity(header: header, child: child)
        
        // When
        let dropDown = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(dropDown, "The DropDown widget should not be nil.")
        XCTAssertTrue(dropDown is DropDown)
    }
    
    func test_whenMapToWidgetIsCalledWithInvalidHeaderContent_thenItShouldThrowAHeaderError() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: nil)
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        let sut = DropDownEntity(header: header, child: child)
        
        // When / Then
        XCTAssertThrowsError(
            try sut.mapToWidget(),
            "Expected to Throw an error, but it didn't."
        )
    }
    
    func test_whenMapToWidgetIsCalledWithInvalidChildContent_thenItShouldThrowAChildError() {
        // Given
        let content = TextEntity(text: "text")
        let header = WidgetEntityContainer(type: "beagle:Text", content: content)
        let child = WidgetEntityContainer(type: "beagle:Text", content: nil)
        let sut = DropDownEntity(header: header, child: child)
        
        // When / Then
        XCTAssertThrowsError(
            try sut.mapToWidget(),
            "Expected to Throw an error, but it didn't."
        )
    }

}
