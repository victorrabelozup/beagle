//
//  TextFieldWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TextFieldWidgetViewRendererTests: XCTestCase {

    func test_onInitWithNoTextFieldWidget_shouldReturnThrowError() {
        // Given
        let widget = UnknownWidget(hint: "", value: "")
        
        // When / Then
        XCTAssertThrowsError(_ = try TextFieldWidgetViewRenderer(widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithTextFieldWidget_shouldReturnTextFieldInstance() {
        // Given
        let widget = TextField(hint: "Email", value: "teste@teste.com")
        
        // When
        guard let textFieldViewRenderer = try? TextFieldWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }

        // Then
        XCTAssertTrue(textFieldViewRenderer.buildView() is UITextField, "Expected a textField type to be created.")
    }
}

private struct UnknownWidget: Widget {
    let hint: String
    let value: String
}
