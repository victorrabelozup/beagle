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
    
    func test_onInitWithNoTextFieldWidget_shouldReturnThrowError() {
        // Given
        let widget = UnknownWidget(text: "")
        
        // When / Then
        XCTAssertThrowsError(_ = try TextWidgetViewRenderer(widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithTextFieldWidget_shouldReturnTextFieldInstance() {
        // Given
        let widget = Text("Test")
        
        // When
        guard let textViewRenderer = try? TextWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }

        // Then
        XCTAssertTrue(textViewRenderer.buildView() is UILabel, "Expected a textField type to be created.")
    }

}

private struct UnknownWidget: Widget {
    let text: String
}
