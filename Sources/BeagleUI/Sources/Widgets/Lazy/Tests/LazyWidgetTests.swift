//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyWidgetTests: XCTestCase {
    
    func test_initWithInitialStateBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let sut = LazyWidget(
            url: "widget",
            initialState: Text("text")
        )

        // Then
        XCTAssert(sut.url == "widget")
        XCTAssert(sut.initialState is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let lazyWidget = LazyWidget(url: "path", initialState: WidgetDummy())
        let context = BeagleContextSpy()
        
        // When
        _ = lazyWidget.toView(context: context, dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(context.didCallLazyLoad)
    }
}
