//
//  ButtonWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonWidgetViewRendererTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_onInitWithNoButtonWidget_shouldReturnThrowError() {
        //Given
        let widget = Image(path: "path")
        
        // When / Then
        XCTAssertThrowsError(_ = try ButtonWidgetViewRenderer(widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithButtonWidget_shouldReturnButtonInstance() {
        //Given
        let widget = Button(text: "title")
        
        //When
        guard let buttonWidgetRenderer = try? ButtonWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }
        
        // Then
        XCTAssertTrue(buttonWidgetRenderer.buildView() is UIButton, "Expected a button type to be created.")
    }
    
    func test_onInitWithButtonWidget_shouldSetRightButtonTitle() {
        //Given
        let buttonTitle = "title"
        let widget = Button(text: buttonTitle)
        
        //When
        guard let buttonWidgetRenderer = try? ButtonWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }
        
        guard let button: UIButton = buttonWidgetRenderer.buildView() as? UIButton else {
            XCTFail("Build View not returning UIButton")
            return
        }
        
        // Then
        XCTAssertEqual(button.titleLabel?.text, buttonTitle)
    }
}

enum unknowWidget: Widget {
    
}
