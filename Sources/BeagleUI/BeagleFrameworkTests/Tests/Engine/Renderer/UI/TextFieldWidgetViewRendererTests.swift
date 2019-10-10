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
            XCTAssertTrue(error is WidgetViewRenderingError, "Expected to have a WidgetViewRenderingError, but got \(error)")
        }
    }
    
    func test_onInitWithTextFieldWidget_shouldReturnUITextFieldInstanceWithIntegratedValues() {
        // Given
        let widget = TextField(hint: "Email", value: "teste@teste.com")
        
        // When
        guard let textFieldViewRenderer = try? TextFieldWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }

        guard let textField = textFieldViewRenderer.buildView() as? UITextField else {
            XCTFail("Unable to type cast to UITextField.")
            return
        }
        
        // Then
        XCTAssertTrue(textFieldViewRenderer.buildView() is UITextField, "Expected a textField type to be created.")
        XCTAssertEqual(widget.value, textField.text, "Expected textfield to have the same text as the widget created, but it doesn`t")
        XCTAssertEqual(widget.hint, textField.placeholder, "Expected textfield to have a placeholder, but it doesn`t")
    }
}

private struct UnknownWidget: Widget {
    let hint: String
    let value: String
}
