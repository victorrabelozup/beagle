//
//  ContainerWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let container = Container(header: WidgetDummy(), content: WidgetDummy(), footer: WidgetDummy())
        guard let renderer = try? ContainerWidgetViewRenderer(
            widget: container,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy) else {
                XCTFail("Could not create renderer.")
                return
        }
        
        // When
        let resultingView = renderer.buildView()
        
        // Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
        XCTAssertTrue(resultingView.subviews.count == 3, "Expected view to have 3 subviews, a header, a content and a footer, but has \(resultingView.subviews)")
    }
    
}

// MARK: - Testing Helpers

final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
    private(set) var setupFlexCalled = false
    private(set) var flexPassed: Flex?
    private(set) var viewPassedToSetupFlex: UIView?
    func setupFlex(_ flex: Flex, for view: UIView) {
        setupFlexCalled = true
        flexPassed = flex
        viewPassedToSetupFlex = view
        
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
