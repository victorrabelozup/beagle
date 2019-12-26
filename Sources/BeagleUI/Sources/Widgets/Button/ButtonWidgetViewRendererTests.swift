//
//  Copyright © 08/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonWidgetViewRendererTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()
    
    // MARK: - Tests
    
    func test_onInitWithNoButtonWidget_shouldReturnThrowError() {
        //Given
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(
            _ = try ButtonWidgetViewRenderer(widget: widget, dependencies: dependencies)
        ) { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithButtonWidget_shouldSetRightButtonTitle() throws {
        //Given
        let buttonTitle = "title"
        let widget = Button(text: buttonTitle)
        let context = BeagleContextDummy()
        
        //When
        let renderer = try ButtonWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let button = renderer.buildView(context: context) as? UIButton else {
            XCTFail("Build View not returning UIButton")
            return
        }
        
        // Then
        XCTAssertEqual(button.titleLabel?.text, buttonTitle)
    }
}

private struct UnknownWidget: NativeWidget { }
