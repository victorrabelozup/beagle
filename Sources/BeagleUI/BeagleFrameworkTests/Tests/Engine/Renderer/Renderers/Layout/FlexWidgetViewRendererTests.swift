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
        XCTAssertTrue(flexConfiguratorSpy.applyFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToApplyFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToApplyFlex)).")
        XCTAssertEqual(flexWidget.flex.size?.height, flexConfiguratorSpy.flexPassed?.size?.height,"Expected \(String(describing: flexWidget.flex.size?.height)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height)).")
        XCTAssertEqual(flexWidget.flex.size?.width, flexConfiguratorSpy.flexPassed?.size?.width,"Expected \(String(describing: flexWidget.flex.size?.width)), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width)).")
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds, "Expected \(numberOfChilds) subview, but got \(resultingView.subviews.count).")
        
    }
}

// MARK: - Testing Helpers

private final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
    private(set) var applyFlexCalled = false
    private(set) var flexPassed: Flex?
    private(set) var viewPassedToApplyFlex: UIView?
    func applyFlex(_ flex: Flex, to view: UIView) {
        applyFlexCalled = true
        flexPassed = flex
        viewPassedToApplyFlex = view
        
    }
    
    private(set) var applyYogaLayoutCalled = false
    private(set) var viewPassedToApplyYogaLayout: UIView?
    private(set) var preservingOriginPassed: Bool?
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {
        applyYogaLayoutCalled = true
        viewPassedToApplyYogaLayout = view
        preservingOriginPassed = preservingOrigin
    }
    
    private(set) var enableYogaCalled = false
    private(set) var enablePassed: Bool?
    private(set) var viewPassedToEnableYoga: UIView?
    func enableYoga(_ enable: Bool, for view: UIView) {
        enableYogaCalled = true
        enablePassed = enable
        viewPassedToEnableYoga = view
    }
    
}
