//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScreenWidgetTests: XCTestCase {

    func test_initWithBuilders_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScreenWidget(
            header: Text("text"),
            content: Text("text"),
            footer: Text("text")
        )

        // Then
        XCTAssert(widget.header is Text)
        XCTAssert(widget.content is Text)
        XCTAssert(widget.footer is Text)
    }
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)
        let container = ScreenWidget(header: WidgetDummy(), content: WidgetDummy(), footer: WidgetDummy())
        let context = BeagleContextDummy()
        
        // When
        let resultingView = container.toView(context: context, dependencies: dependencies)
        
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
    
    func test_contentShouldUseOnlyTheSpaceRequiredByFlexRules() {
        
        let screen = ScreenWidget(
            safeArea: SafeArea.all,
            navigationBar: .init(title: "Test Flex"),
            content: FlexSingleWidget(
                child: FlexSingleWidget(
                    child: Text("Line 0,\nLine 1,\nLine 2,\nLine 3,\nLine 4."),
                    flex: .init(alignSelf: .center, size: .init(width: 50%, height: 25%)),
                    appearance: .init(backgroundColor: "#FF0000")
                ),
                flex: .init(justifyContent: .center),
                appearance: .init(backgroundColor: "#00FF00")
            )
        )
        
        let viewController = BeagleScreenViewController(viewModel: .init(screenType: .declarative(screen)))
        assertSnapshotImage(viewController)
    }
    
    func test_navigationBarButtonItemWithImage() {
        let dependencies = BeagleDependencies()
        dependencies.appBundle = Bundle(for: ScreenWidgetTests.self)
        Beagle.dependencies = dependencies
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }
        
        let barItem = NavigationBarItem(image: "shuttle", text: "shuttle", action: ActionDummy())
        
        let screen = ScreenWidget(
            safeArea: SafeArea.none,
            navigationBar: .init(title: "title", showBackButton: true, navigationBarItems: [barItem]),
            content: Text("")
        )
        
        let viewController = BeagleScreenViewController(viewModel: .init(screenType: .declarative(screen)))
        assertSnapshotImage(viewController, size: CGSize(width: 300, height: 200))
    }
    
    func test_navigationBarButtonItemWithText() {
        let barItem = NavigationBarItem(text: "shuttle", action: ActionDummy())
        
        let screen = ScreenWidget(
            safeArea: SafeArea.all,
            navigationBar: .init(title: "title", showBackButton: true, navigationBarItems: [barItem]),
            content: Text("test")
        )
        
        let viewController = BeagleScreenViewController(viewModel: .init(screenType: .declarative(screen)))
        assertSnapshotImage(viewController, size: CGSize(width: 300, height: 200))
    }
    
    func test_action_shouldBeTriggered() {
        // Given
        let action = ActionDummy()
        let barItem = NavigationBarItem(text: "shuttle", action: action)
        let context = BeagleContextSpy()
        
        // When
        let resultingView = barItem.toBarButtonItem(context: context, dependencies: RendererDependenciesContainer())
        _ = resultingView.target?.perform(resultingView.action)
        
        // Then
        XCTAssertTrue(context.didCallDoAction)
        XCTAssertEqual(context.actionCalled as? ActionDummy, action)
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
