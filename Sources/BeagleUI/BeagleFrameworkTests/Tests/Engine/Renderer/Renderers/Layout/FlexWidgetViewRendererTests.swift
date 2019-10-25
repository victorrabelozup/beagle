//
//  FlexWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        
        //Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let numberOfChilds = 3
        let flexWidgetChilds = Array(repeating: WidgetDummy(), count: numberOfChilds)
        let flexWidget = FlexWidget(children: flexWidgetChilds)
        guard let renderer = try? FlexWidgetViewRenderer(
            widget: flexWidget,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy) else {
                XCTFail()
                return
        }
        
        // When
        let resultingView = renderer.buildView()
        
        //Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
        XCTAssertEqual(flexWidget.flex.size?.height, flexConfiguratorSpy.flexPassed?.size?.height,"Expected \(String(describing: flexWidget.flex.size?.height)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height)).")
        XCTAssertEqual(flexWidget.flex.size?.width, flexConfiguratorSpy.flexPassed?.size?.width,"Expected \(String(describing: flexWidget.flex.size?.width)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width)).")
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds, "Expected \(numberOfChilds) subview, but got \(resultingView.subviews.count).")
        
    }
}
