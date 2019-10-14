//
//  TextWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TextWidgetViewRendererTests: XCTestCase {
    
    func test_onInitWithNoTextWidget_shouldReturnThrowError() {
        // Given
        let unkownWidget = WidgetDummy()
        
        // When / Then
        XCTAssertThrowsError(_ = try TextWidgetViewRenderer(unkownWidget), "Expected error, but got nil.") { error in
            XCTAssertTrue(error is WidgetViewRenderingError, "Expected to have a WidgetViewRenderingError, but got \(error)")
        }
    }
    
    func test_onInitWithTextWidget_shouldReturnUILabelInstanceWithIntegratedValues() {
        // Given
        let widget = Text("Test")
        
        // When
        guard let textViewRenderer = try? TextWidgetViewRenderer(widget) else {
            XCTFail("Could not render Text.")
            return
        }
        
        guard let label = textViewRenderer.buildView() as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(widget.text, label.text, "Expected label to have the same text as widget when created, but it doesn`t.")
    }
    
}
