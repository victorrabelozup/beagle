//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class FlexSingleWidgetTests: XCTestCase {
    
    func test_initWithChild_shouldReturnFlexSingleWidgetAndSetDependenciesProperly() {
        // Given
        let sut = FlexSingleWidget(child: Text("Teste"), flex: Flex())
        let mirror = Mirror(reflecting: sut)
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let widget = mirror.firstChild(of: Widget.self)
        // Then
        XCTAssertNotNil(flex, "Expected a valid instance of type `Flex`, but got nil.")
        XCTAssertNotNil(widget, "Expected a valid instance of type `Widget`, but got nil.")
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let widget = FlexSingleWidget {
            Text("Some texts")
        }
        // When
        let flexSingleWidget = widget.apply(Flex(justifyContent: .center))
        // Then
        XCTAssertNotNil(flexSingleWidget.flex, "Expected to have a flex widget to have flex attribute, but got none.")
    }
    
    func test_whenDecodingJson_shouldReturnAFlexSingleWidget() throws {
        let widget: FlexSingleWidget = try widgetFromJsonFile(fileName: "FlexSingleWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexSingleWidget() {
        guard let widget: FlexSingleWidget = try? widgetFromJsonFile(fileName: "FlexSingleWidget") else {
            XCTFail("Failed to load FlexSingleWidget.json")
            return
        }
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget))
        )
        assertSnapshot(matching: screen, as: .image)
    }
}
