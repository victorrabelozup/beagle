//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ScrollViewTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScrollView(children: [
            Text("text")
        ])
        
        // Then
        XCTAssertEqual(widget.children.count, 1)
        XCTAssertTrue(widget.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScrollView(children: [
            Text("text"),
            Button(text: "text")
        ])
        
        // Then
        XCTAssert(widget.children.count == 2)
        XCTAssert(widget.children[safe: 0] is Text)
        XCTAssert(widget.children[safe: 1] is Button)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)
        
        let container = ScrollView(children: [
            WidgetDummy()
        ])

        // When
        let resultingView = container.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        // Then
        XCTAssert(flexSpy.setupFlexCalled)
        XCTAssert(resultingView.subviews.count == 1)
        XCTAssert(flexSpy.timesPassed == 1)
    }
    
    func test_whenLayoutSubViewsIsCalledOnBagleContainerScrollView_itShouldSetupTheContentSizeCorrectly() {
        // Given
        let subview = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        let sut = BeagleContainerScrollView()
        sut.addSubview(subview)

        // When
        sut.layoutSubviews()

        // Then
        XCTAssert(subview.frame.size == sut.contentSize)
        
    }
    
    func test_whenDecodingJson_shouldReturnAScrollView() throws {
        let widget: ScrollView = try widgetFromJsonFile(fileName: "ScrollViewWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderFlexWidget() throws {
        let widget: ScrollView = try widgetFromJsonFile(fileName: "ScrollViewWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget.toScreen()))
        )
        assertSnapshotImage(screen)
    }

}
