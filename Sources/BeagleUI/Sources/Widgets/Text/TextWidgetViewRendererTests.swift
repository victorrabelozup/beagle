//
//  Copyright © 09/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TextWidgetViewRendererTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()
    
    func test_onInitWithNoTextWidget_shouldReturnThrowError() {
        // Given
        let unkownWidget = WidgetDummy()
        
        // When / Then
        XCTAssertThrowsError(
            _ = try TextWidgetViewRenderer(widget: unkownWidget, dependencies: dependencies)
        ) { error in
            XCTAssertTrue(error is ViewRendererError)
        }
    }
    
    func testEqualTextContent() throws {
        // Given
        let widget = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        let renderer = try TextWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let label = renderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(widget.text, label.text)
    }
    
    func testTextWithRightAlignment() throws {
        // Given
        let widget = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        let renderer = try TextWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let label = renderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(label.textAlignment, NSTextAlignment.natural)
    }
    
    func testTextWithLeftAlignment() throws {
        // Given
        let widget = Text("Test", alignment: .left)
        let context = BeagleContextDummy()
        
        // When
        let renderer = try TextWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let label = renderer.buildView(context: context) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(label.textAlignment, NSTextAlignment.left)
    }
    
}
