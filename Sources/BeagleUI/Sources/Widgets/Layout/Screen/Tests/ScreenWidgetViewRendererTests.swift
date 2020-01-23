//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScreenWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        let container = ScreenWidget(header: WidgetDummy(), content: WidgetDummy(), footer: WidgetDummy())
        guard let renderer = try? ScreenWidgetViewRenderer(
            widget: container,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        // Then
        XCTAssert(flexSpy.setupFlexCalled)
        XCTAssert(resultingView.subviews.count == 3)
    }
    
    func test_whenLayoutSubViewsIsCalledOnBagleContainerScrollView_itShouldSetupTheContentSizeCorrectly() {
        // Given
        let subview = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        let sut = BeagleContainerScrollView()
        sut.addSubview(subview)
        
        // When
        sut.layoutSubviews()
        
        // Then
        XCTAssert(subview.frame.size == sut.contentSize)
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
    private(set) var applyYogaLayoutCallCount = 0

    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {
        applyYogaLayoutCallCount += 1
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
