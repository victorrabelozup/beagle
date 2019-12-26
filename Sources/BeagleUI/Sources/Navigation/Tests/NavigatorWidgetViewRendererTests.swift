//
//  NavigatorWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 11/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigatorWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let rendererProviderSpy = RendererProviderSpy()
        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererProviderSpy
        )

        let navigator = Navigator(action: Navigate(type: .popView), child: WidgetDummy())

        guard let renderer = try? NavigatorWidgetViewRenderer(
            widget: navigator,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }

        // When
        _ = renderer.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererProviderSpy.buildRendererCount, 1, "Expected to call `buildRenderer` once.")
    }
}

final class RendererProviderSpy: RendererProvider {
    
    private(set) var buildRendererCount = 0
    
    func buildRenderer(for widget: Widget, dependencies: ViewRenderer.Dependencies) -> ViewRenderer {
        buildRendererCount += 1
        return ViewRendererProtocolDummy()
    }
}
