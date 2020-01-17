//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class FlexWidgetTests: XCTestCase {
    
    func test_initWithChildren_shouldReturnFlexWidgetAndSetDependenciesProperly() {
        // Given
        let sut = FlexWidget(children: [
            Text("Some texts."),
            Text("More texts.")
        ], flex: Flex())
        
        let mirror = Mirror(reflecting: sut)
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let widget = mirror.firstChild(of: [Widget].self)
        // Then
        XCTAssertTrue(sut.children.count == 2)
        XCTAssertNotNil(flex)
        XCTAssertNotNil(widget)
        
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let widget = FlexWidget(children: [
            Text("Some texts")
        ])
        // When
        let flexWidget = widget.applyFlex(Flex(justifyContent: .center))
        // Then
        XCTAssertNotNil(flexWidget.flex)
    }
    
    func test_whenDecodingJson_shouldReturnAFlexWidget() throws {
        let widget: FlexWidget = try widgetFromJsonFile(fileName: "FlexWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexWidget() throws {
        let widget: FlexWidget = try widgetFromJsonFile(fileName: "FlexWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget))
        )
        assertSnapshotImage(screen, size: ViewImageConfig.iPhoneXr.size!)
    }
}
