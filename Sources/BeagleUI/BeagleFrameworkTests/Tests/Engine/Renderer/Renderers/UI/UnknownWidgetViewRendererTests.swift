//
//  UnknownWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UnknownWidgetViewRendererTests: XCTestCase {
    
    func test_initUnknownWidgetView_shouldConfigureALabelWithTheRightParameters() {
        // Given
        let unknownWidget = WidgetDummy()
        let unknownWidgetViewRenderer = UnknownWidgetViewRenderer(unknownWidget)
        let anyWidget = AnyWidget(value: unknownWidget as Any)
        let expectedText = "Unknown Widget of type:\n \(String(describing: anyWidget))"
        
        // When
        let builtView = unknownWidgetViewRenderer.buildView()
        guard let widgetView = builtView as? UILabel else {
            XCTFail("Expected a UILabel, but got \(String(describing: type(of: builtView))).")
            return
        }
        
        // Then
        XCTAssertEqual(widgetView.text, expectedText, "Expected `\(expectedText)`, but got \(String(describing: widgetView.text)).")
        XCTAssertEqual(widgetView.textColor, .red, "Expected `red`, but got \(String(describing: widgetView.textColor)).")
        XCTAssertEqual(widgetView.backgroundColor, .yellow, "Expected `\(expectedText)`, but got \(String(describing: widgetView.backgroundColor)).")
    }

}
