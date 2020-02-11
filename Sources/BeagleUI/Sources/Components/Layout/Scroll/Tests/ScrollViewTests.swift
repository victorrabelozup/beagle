//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ScrollViewTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let component = ScrollView(children: [
            Text("text")
        ])
        
        // Then
        XCTAssertEqual(component.children.count, 1)
        XCTAssertTrue(component.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let component = ScrollView(children: [
            Text("text"),
            Button(text: "text")
        ])
        
        // Then
        XCTAssert(component.children.count == 2)
        XCTAssert(component.children[safe: 0] is Text)
        XCTAssert(component.children[safe: 1] is Button)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)
        
        let container = ScrollView(children: [
            ComponentDummy()
        ])

        // When
        let resultingView = container.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        // Then
        XCTAssert(flexSpy.setupFlexCalled)
        XCTAssertEqual(resultingView.subviews.count, 1)
        XCTAssertEqual(flexSpy.timesPassed, 2)
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
        let component: ScrollView = try componentFromJsonFile(fileName: "ScrollViewComponent")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderScrollView() throws {
        let component: ScrollView = try componentFromJsonFile(fileName: "ScrollViewComponent")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(component.toScreen()))
        )
        assertSnapshotImage(screen)
    }

}
