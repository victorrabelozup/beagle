//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ContainerTests: XCTestCase {
    
    func test_initWithChildren_shouldReturnContainerAndSetDependenciesProperly() {
        // Given
        let sut = Container(children: [
            Text("Some texts."),
            Text("More texts.")
        ], flex: Flex())
        
        let mirror = Mirror(reflecting: sut)
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let component = mirror.firstChild(of: [ServerDrivenComponent].self)
        // Then
        XCTAssertTrue(sut.children.count == 2)
        XCTAssertNotNil(flex)
        XCTAssertNotNil(component)
        
    }
    
    func test_applyFlex_shouldReturnContainer() {
        // Given
        let component = Container(children: [
            Text("Some texts")
        ])
        // When
        let container = component.applyFlex(Flex(justifyContent: .center))
        // Then
        XCTAssertNotNil(container.flex)
    }
    
    func test_toView_shouldReturnTheExpectedView() throws {
        //Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        let numberOfChilds = 3
        let containerChilds = Array(repeating: ComponentDummy(), count: numberOfChilds)
        let container = Container(children: containerChilds)
        
        // When
        let resultingView = container.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        //Then
        XCTAssertTrue(flexSpy.setupFlexCalled)
        XCTAssertEqual(resultingView, flexSpy.viewPassedToSetupFlex)
        XCTAssertEqual(container.flex?.size?.height, flexSpy.flexPassed?.size?.height)
        XCTAssertEqual(container.flex?.size?.width, flexSpy.flexPassed?.size?.width)
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds)
    }
    
    func test_whenDecodingJson_shouldReturnAContainer() throws {
        let component: Container = try componentFromJsonFile(fileName: "Container")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderContainer() throws {
        let component: Container = try componentFromJsonFile(fileName: "Container")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(component.toScreen()))
        )
        assertSnapshotImage(screen, size: ViewImageConfig.iPhoneXr.size!)
    }
}
