//
//  FlexSingleWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexSingleWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        
        // Given
        let expectedNumberOfSubviews = 1
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let flexWidget = FlexSingleWidget(child: WidgetDummy())
        guard let renderer = try? FlexSingleWidgetViewRenderer(widget: flexWidget, rendererProvider: WidgetRendererProviderDummy(), flexViewConfigurator: flexConfiguratorSpy) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        //Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
        XCTAssertEqual(flexWidget.flex.size?.height, flexConfiguratorSpy.flexPassed?.size?.height,"Expected \(String(describing: flexWidget.flex.size?.height)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height)).")
        XCTAssertEqual(flexWidget.flex.size?.width, flexConfiguratorSpy.flexPassed?.size?.width,"Expected \(String(describing: flexWidget.flex.size?.width)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width)).")
        XCTAssertEqual(resultingView.subviews.count, expectedNumberOfSubviews, "Expected \(expectedNumberOfSubviews) subview, but got \(resultingView.subviews.count).")
        
    }
}
