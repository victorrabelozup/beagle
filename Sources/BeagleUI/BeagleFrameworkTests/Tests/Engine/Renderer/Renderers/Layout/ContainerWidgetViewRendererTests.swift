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
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        // Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
        XCTAssertTrue(resultingView.subviews.count == 3, "Expected view to have 3 subviews, a header, a content and a footer, but has \(resultingView.subviews)")
    }
    
    func test_whenLayoutSubViewsIsCalledOnBagleContainerScrollView_itShouldSetupTheContentSizeCorrectly() {
        // Given
        let subview = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        let sut = BeagleContainerScrollView()
        sut.addSubview(subview)
        
        // When
        sut.layoutSubviews()
        
        // Then
        XCTAssertEqual(subview.frame.size, sut.contentSize, "Expected \(subview.frame.size), but got \(sut.contentSize).")
    }
    
}

// MARK: - Testing Helpers

final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
    private(set) var setupFlexCalled = false
    private(set) var flexPassed: Flex?
    private(set) var viewPassedToSetupFlex: UIView?
    private(set) var timesPassed: Int = 0
    func setupFlex(_ flex: Flex, for view: UIView) {
        setupFlexCalled = true
        flexPassed = flex
        viewPassedToSetupFlex = view
        timesPassed += 1
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
    
    private(set) var viewPassedToInstrinsicSize: UIView?
    func instrinsicSize(for view: UIView) -> CGSize {
        viewPassedToInstrinsicSize = view
        return view.frame.size
    }
    
}

final class ActionExecutorDummy: ActionExecutor {
    func doAction(_ action: Action, sender: Any, context: BeagleContext) {
    }
}

final class ActionExecutorSpy: ActionExecutor {
    private(set) var didCallDoAction = false
    func doAction(_ action: Action, sender: Any, context: BeagleContext) {
        didCallDoAction = true
    }
}
