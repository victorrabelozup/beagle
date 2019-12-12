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
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(_ = try ButtonWidgetViewRenderer(widget: widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithButtonWidget_shouldSetRightButtonTitle() {
        //Given
        let buttonTitle = "title"
        let widget = Button(text: buttonTitle)
        let context = BeagleContextDummy()
        
        //When
        guard let buttonWidgetRenderer = try? ButtonWidgetViewRenderer(widget: widget) else {
            XCTFail("Could not render Button.")
            return
        }
        
        guard let button: UIButton = buttonWidgetRenderer.buildView(context: context) as? UIButton else {
            XCTFail("Build View not returning UIButton")
            return
        }
        
        // Then
        XCTAssertEqual(button.titleLabel?.text, buttonTitle)
    }
}

private struct UnknownWidget: NativeWidget { }
