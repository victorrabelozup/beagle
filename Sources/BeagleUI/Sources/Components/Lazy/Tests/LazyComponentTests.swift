//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyComponentTests: XCTestCase {
    
    func test_initWithInitialStateBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let sut = LazyComponent(
            path: "component",
            initialState: Text("text")
        )

        // Then
        XCTAssert(sut.path == "component")
        XCTAssert(sut.initialState is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let lazyComponent = LazyComponent(path: "path", initialState: ComponentDummy())
        let context = BeagleContextSpy()
        
        // When
        _ = lazyComponent.toView(context: context, dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(context.didCallLazyLoad)
    }
}
