//
//  SpacerWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SpacerWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let spacer = Spacer(1.0)
        guard let renderer = try? SpacerWidgetViewRenderer(
            widget: spacer,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        
        // When
        let resultingView = renderer.buildView()
    
        // Then
        XCTAssertTrue(flexConfiguratorSpy.applyFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.width?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width?.value)).")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.height?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height?.value)).")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToApplyFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToApplyFlex)).")
    }
    
}

// MARK: - Testing Helpers

private final class WidgetViewRendererProtocolDummy: WidgetViewRendererProtocol {
    init() { }
    init(_ widget: Widget) throws {}
    func buildView() -> UIView { return UIView() }
}

private class WidgetRendererProviderDummy: WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        return WidgetViewRendererProtocolDummy()
    }
}

final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
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
