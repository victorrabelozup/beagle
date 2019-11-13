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
        let widgetRendererProvider = WidgetRendererProviderSpy()
        let flexConfigurator = FlexViewConfiguratorDummy()
        let navigator = Navigator(action: Navigate(type: .popView), child: WidgetDummy())
        guard let renderer = try? NavigatorWidgetViewRenderer(
            widget: navigator,
            rendererProvider: widgetRendererProvider,
            flexViewConfigurator: flexConfigurator) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
                
        // When
        let _ = renderer.buildView(context: context)
        
        // Then
        XCTAssertEqual(widgetRendererProvider.buildRendererCount, 1, "Expected to call `buildRenderer` once.")
    }
}

final class WidgetRendererProviderSpy: WidgetRendererProvider {
    
    private(set) var buildRendererCount = 0
    
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        buildRendererCount += 1
        return WidgetViewRendererProtocolDummy()
    }
}
