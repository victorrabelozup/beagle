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
        let widgetRendererProvider = WidgetRendererProviderSpy()
        let flexConfigurator = FlexViewConfiguratorDummy()
        let applicationTheme = AppThemeDummy()
        let validatorHandler = ValidatorHandling()
        let lazyWidget = LazyWidget(url: "path", initialState: WidgetDummy())
        guard let sut = try? LazyWidgetViewRenderer(
            widget: lazyWidget,
            rendererProvider: widgetRendererProvider,
            flexViewConfigurator: flexConfigurator,
            applicationTheme: applicationTheme,
            validatorHandler: validatorHandler
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextSpy()
                
        // When
        let _ = sut.buildView(context: context)
        
        // Then
        XCTAssertEqual(widgetRendererProvider.buildRendererCount, 1)
        XCTAssertTrue(context.didCallLazyLoad)
    }
}
