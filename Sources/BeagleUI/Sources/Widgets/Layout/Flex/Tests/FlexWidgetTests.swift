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
    
    func test_toView_shouldReturnTheExpectedView() throws {
        //Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        let numberOfChilds = 3
        let flexWidgetChilds = Array(repeating: WidgetDummy(), count: numberOfChilds)
        let flexWidget = FlexWidget(children: flexWidgetChilds)
        
        // When
        let resultingView = flexWidget.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        //Then
        XCTAssertTrue(flexSpy.setupFlexCalled)
        XCTAssertEqual(resultingView, flexSpy.viewPassedToSetupFlex)
        XCTAssertEqual(flexWidget.flex.size?.height, flexSpy.flexPassed?.size?.height)
        XCTAssertEqual(flexWidget.flex.size?.width, flexSpy.flexPassed?.size?.width)
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds)
    }
    
    func test_whenDecodingJson_shouldReturnAFlexWidget() throws {
        let widget: FlexWidget = try widgetFromJsonFile(fileName: "FlexWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexWidget() throws {
        let widget: FlexWidget = try widgetFromJsonFile(fileName: "FlexWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget.toScreen()))
        )
        assertSnapshotImage(screen, size: ViewImageConfig.iPhoneXr.size!)
    }
}
