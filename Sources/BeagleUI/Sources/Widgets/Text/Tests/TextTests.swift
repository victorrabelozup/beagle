//
//  Copyright © 03/01/20 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class TextTests: XCTestCase {
    
    private lazy var theme = AppTheme(styles: [
        "test.text.style": textStyle
    ])
    
    private func textStyle() -> (UILabel?) -> Void {
        return BeagleStyle.label(font: .boldSystemFont(ofSize: 20), color: .blue)
            <> BeagleStyle.backgroundColor(withColor: .black)
    }

    private lazy var dependencies = RendererDependenciesContainer(
        theme: theme
    )
    
    func testEqualTextContent() throws {
        // Given
        let widget = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        guard let label = widget.toView(context: BeagleContextDummy(), dependencies: dependencies) as? UILabel else {
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
        guard let label = widget.toView(context: BeagleContextDummy(), dependencies: dependencies) as? UILabel else {
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
        guard let label = widget.toView(context: BeagleContextDummy(), dependencies: dependencies) as? UILabel else {
            XCTFail("Unable to type cast to UILabel.")
            return
        }
        
        // Then
        XCTAssertEqual(label.textAlignment, NSTextAlignment.left)
    }
    
    func test_whenDecodingJson_shouldReturnAText() throws {
        let widget: Text = try widgetFromJsonFile(fileName: "TextWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderTextWidget() throws {
        let widget: Text = try widgetFromJsonFile(fileName: "TextWidget")
        let view = widget.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: CGSize(width: 300, height: 150))
    }

}
