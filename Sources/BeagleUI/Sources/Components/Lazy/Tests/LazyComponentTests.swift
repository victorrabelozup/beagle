//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyComponentTests: XCTestCase {
    
    func test_initWithInitialStateBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let sut = LazyComponent(
            url: "component",
            initialState: Text("text")
        )

        // Then
        XCTAssert(sut.url == "component")
        XCTAssert(sut.initialState is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let lazyComponent = LazyComponent(url: "path", initialState: ComponentDummy())
        let context = BeagleContextSpy()
        
        // When
        _ = lazyComponent.toView(context: context, dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(context.didCallLazyLoad)
    }
}
