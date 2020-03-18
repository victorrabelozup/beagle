//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ScreenComponentTests: XCTestCase {

    func test_initWithBuilders_shouldReturnExpectedInstance() {
        // Given / When
        let component = ScreenComponent(
            child: Text("text")
        )

        // Then
        XCTAssert(component.child is Text)
    }
    
    func test_contentShouldUseOnlyTheSpaceRequiredByFlexRules() {
        
        let component = ScreenComponent(
            safeArea: SafeArea.all,
            navigationBar: .init(title: "Test Flex"),
            child: Container(
                children: [
                    Container(
                        children: [Text("Line 0,\nLine 1,\nLine 2,\nLine 3,\nLine 4.")],
                        flex: .init(alignSelf: .center, size: .init(width: 50%, height: 25%)),
                        appearance: .init(backgroundColor: "#FF0000")
                    )
                ],
                flex: .init(justifyContent: .center),
                appearance: .init(backgroundColor: "#00FF00")
            )
        )
        
        let viewController = Beagle.screen(.declarative(component.toScreen()))
        assertSnapshotImage(viewController)
    }
    
    func test_navigationBarButtonItemWithImage() {
        let dependencies = BeagleDependencies()
        dependencies.appBundle = Bundle(for: ScreenComponentTests.self)
        Beagle.dependencies = dependencies
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }
        
        let barItem = NavigationBarItem(image: "shuttle", text: "shuttle", action: ActionDummy())
        
        let component = ScreenComponent(
            safeArea: SafeArea.none,
            navigationBar: .init(title: "title", showBackButton: true, navigationBarItems: [barItem]),
            child: Text("")
        )
        
        let viewController = Beagle.screen(.declarative(component.toScreen()))
        assertSnapshotImage(viewController, size: CGSize(width: 300, height: 200))
    }
    
    func test_navigationBarButtonItemWithText() {
        let barItem = NavigationBarItem(text: "shuttle", action: ActionDummy())
        
        let component = ScreenComponent(
            safeArea: SafeArea.all,
            navigationBar: .init(title: "title", showBackButton: true, navigationBarItems: [barItem]),
            child: Text("test")
        )
        
        let viewController = Beagle.screen(.declarative(component.toScreen()))
        assertSnapshotImage(viewController, size: CGSize(width: 300, height: 200))
    }
    
    func test_action_shouldBeTriggered() {
        // Given
        let action = ActionDummy()
        let barItem = NavigationBarItem(text: "shuttle", action: action)
        let context = BeagleContextSpy()
        
        // When
        let resultingView = barItem.toBarButtonItem(context: context, dependencies: BeagleScreenDependencies())
        _ = resultingView.target?.perform(resultingView.action)
        
        // Then
        XCTAssertTrue(context.didCallDoAction)
        XCTAssertEqual(context.actionCalled as? ActionDummy, action)
    }
    
    func test_shouldPrefetchNavigateAction() {
        let prefetch = BeaglePrefetchHelpingSpy()
        let dependencies = BeagleScreenDependencies(preFetchHelper: prefetch)
        
        let navigatePath = "button-item-prefetch"
        let navigate = Navigate.addView(.init(path: navigatePath, shouldPrefetch: true))
        let barItem = NavigationBarItem(text: "Item", action: navigate)
        let screen = ScreenComponent(
            navigationBar: NavigationBar(title: "Prefetch", navigationBarItems: [barItem]),
            child: ComponentDummy()
        )
        
        _ = screen.toView(context: BeagleContextDummy(), dependencies: dependencies)
        XCTAssertEqual([navigatePath], prefetch.prefetched)
    }
    
    func test_whenDecodingJson_thenItShouldReturnAScreen() throws {
        let component: ScreenComponent = try componentFromJsonFile(fileName: "screenComponent")
        assertSnapshot(matching: component, as: .dump)
    }
}

// MARK: - Testing Helpers

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
