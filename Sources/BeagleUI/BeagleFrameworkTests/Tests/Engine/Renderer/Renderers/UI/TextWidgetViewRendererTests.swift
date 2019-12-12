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
        XCTAssertThrowsError(_ = try TextWidgetViewRenderer(widget: unkownWidget), "Expected error, but got nil.") { error in
            XCTAssertTrue(error is WidgetViewRenderingError, "Expected to have a WidgetViewRenderingError, but got \(error)")
        }
    }
    
    func test_onInitWithTextWidget_shouldReturnUILabelInstanceWithIntegratedValues() {
        // Given
        let widget = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        guard let textViewRenderer = try? TextWidgetViewRenderer(widget: widget) else {
            XCTFail("Could not render Text.")
            return
        }
        
        guard let label = textViewRenderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(widget.text, label.text, "Expected label to have the same text as widget when created, but it doesn`t.")
    }
    
    func test_onInitWithTextWidget_shouldReturnUILabelWithRightAlignment() {
        // Given
        let widget = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        guard let textViewRenderer = try? TextWidgetViewRenderer(widget: widget) else {
            XCTFail("Could not render Text.")
            return
        }
        
        guard let label = textViewRenderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(NSTextAlignment.natural, label.textAlignment, "Expect allignment to be natural")
    }
    
    func test_onInitWithTextWidgetAndAlignment_shouldReturnUILabelWithRightAlignment() {
        // Given
        let widget = Text("Test", alignment: .left)
        let context = BeagleContextDummy()
        
        // When
        guard let textViewRenderer = try? TextWidgetViewRenderer(widget: widget) else {
            XCTFail("Could not render Text.")
            return
        }
        
        guard let label = textViewRenderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(NSTextAlignment.left, label.textAlignment, "Expect allignment to be left")
    }
    
}
