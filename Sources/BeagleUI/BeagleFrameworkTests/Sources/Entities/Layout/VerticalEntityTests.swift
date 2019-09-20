//
//  VerticalEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class VerticalEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAVerticalWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [WidgetEntityContainer(type: "beagle:Text", content: content)]
        let flex = FlexEntity.fixture()
        let sut = VerticalEntity(children: children, flex: flex, reversed: false)
        
        // When
        let vertical = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(vertical, "The Vertical widget should not be nil.")
        XCTAssertTrue(vertical is Vertical)
    }
    
    func test_whenMapToWidgetIsCalledWithNoChildrens_thenItShouldReturnAVerticalWidget() {
        // Given
        let flex = FlexEntity.fixture()
        let sut = VerticalEntity(children: [], flex: flex, reversed: false)
        
        // When
        let vertical = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(vertical, "The Vertical widget should not be nil.")
        XCTAssertTrue(vertical is Vertical)
        guard let verticalWidget = vertical as? Vertical else {
            XCTFail("Could not convert Widget to Vertical.")
            return
        }
        XCTAssertEqual(verticalWidget.children.count, 0, "Expected 0 childrens, but found \(verticalWidget.children.count)")
    }
    
}
