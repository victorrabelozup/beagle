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
        let flexWidget = FlexSingleWidget(child: WidgetDummy())

        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        guard let renderer = try? FlexSingleWidgetViewRenderer(
            widget: flexWidget,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        //Then
        XCTAssert(flexSpy.setupFlexCalled)
        XCTAssert(resultingView == flexSpy.viewPassedToSetupFlex)
        XCTAssert(flexWidget.flex.size?.height == flexSpy.flexPassed?.size?.height)
        XCTAssert(flexWidget.flex.size?.width == flexSpy.flexPassed?.size?.width)
        XCTAssert(resultingView.subviews.count == expectedNumberOfSubviews)
        
    }
}
