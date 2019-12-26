//
//  LazyWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 28/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let rendererProviderSpy = RendererProviderSpy()
        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererProviderSpy
        )

        let lazyWidget = LazyWidget(url: "path", initialState: WidgetDummy())
        guard let sut = try? LazyWidgetViewRenderer(
            widget: lazyWidget,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextSpy()
                
        // When
        _ = sut.buildView(context: context)
        
        // Then
        XCTAssertEqual(rendererProviderSpy.buildRendererCount, 1)
        XCTAssertTrue(context.didCallLazyLoad)
    }
}
