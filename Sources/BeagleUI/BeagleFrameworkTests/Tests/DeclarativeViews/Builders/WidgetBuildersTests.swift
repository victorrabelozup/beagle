//
//  WidgetBuildersTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 03/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetBuildersTests: XCTestCase {
    
    func test_widgetBuilder_shouldBuildWidget() {
        // Given
        let widgetToBuild = Text("text")
        
        // When
        let widgetBuilt = WidgetBuilder.buildBlock(widgetToBuild)
        
        // Then
        XCTAssertTrue(widgetBuilt is Text, "Expected `Text`, but got \(widgetBuilt).")
    }
    
    func test_widgetArrayBuilder_shouldBuildArrayOfWidgets() {
        // Given / When
        let widgetArrayBuilt = WidgetArrayBuilder.buildBlock(
            Text("tetxt"),
            Button(text: "button")
        )
        
        // Then
        XCTAssertEqual(widgetArrayBuilt.count, 2, "Expected `2`, but got \(widgetArrayBuilt.count).")
        XCTAssertTrue(widgetArrayBuilt[safe: 0] is Text, "Expected `Text`, but got \(String(describing: widgetArrayBuilt[safe: 0])).")
        XCTAssertTrue(widgetArrayBuilt[safe: 1] is Button, "Expected `Button`, but got \(String(describing: widgetArrayBuilt[safe: 1])).")
    }
    
}
