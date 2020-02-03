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
        XCTAssertNotNil(flex)
        XCTAssertNotNil(widget)
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let widget = FlexSingleWidget(child:
            Text("Some texts")
        )
        // When
        let flexSingleWidget = widget.apply(Flex(justifyContent: .center))
        // Then
        XCTAssertNotNil(flexSingleWidget.flex)
    }
    
    func test_whenDecodingJson_shouldReturnAFlexSingleWidget() throws {
        let widget: FlexSingleWidget = try widgetFromJsonFile(fileName: "FlexSingleWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexSingleWidget() throws {
        let widget: FlexSingleWidget = try widgetFromJsonFile(fileName: "FlexSingleWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget.toScreen()))
        )
        assertSnapshotImage(screen, size: CGSize(width: 300, height: 100))
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        
        // Given
        let expectedNumberOfSubviews = 1
        let flexWidget = FlexSingleWidget(child: WidgetDummy())
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        // When
        let resultingView = flexWidget.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        //Then
        XCTAssert(flexSpy.setupFlexCalled)
        XCTAssert(resultingView == flexSpy.viewPassedToSetupFlex)
        XCTAssert(flexWidget.flex.size?.height == flexSpy.flexPassed?.size?.height)
        XCTAssert(flexWidget.flex.size?.width == flexSpy.flexPassed?.size?.width)
        XCTAssert(resultingView.subviews.count == expectedNumberOfSubviews)
        
    }
}
