//
//  Copyright © 08/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()
    
    func test_toView_shouldSetRightButtonTitle() {
        //Given
        let buttonTitle = "title"
        let component = Button(text: buttonTitle)
        let context = BeagleContextDummy()
        
        //When        
        guard let button = component.toView(context: context, dependencies: dependencies) as? UIButton else {
            XCTFail("Build View not returning UIButton")
            return
        }
        
        // Then
        XCTAssertEqual(button.titleLabel?.text, buttonTitle)
    }
    
    func test_toView_shouldApplyButtonStyle() {
        
        let theme = ThemeSpy()
        let dependencies = RendererDependenciesContainer(theme: theme)
        
        let style = "test.button.style"
        let button = Button(text: "apply style", style: style)
        
        let view = button.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        XCTAssertEqual(view, theme.styledView)
        XCTAssertEqual(style, theme.styleApplied)
    }
    
    func test_toView_shouldPrefetchNavigateAction() {
        let prefetch = BeaglePrefetchHelpingSpy()
        let dependencies = RendererDependenciesContainer(preFetchHelper: prefetch)
        
        let navigatePath = "path-to-prefetch"
        let navigate = Navigate.presentView(.init(path: navigatePath, shouldPrefetch: true))
        let button = Button(text: "prefetch", action: navigate)
        
        _ = button.toView(context: BeagleContextDummy(), dependencies: dependencies)
        XCTAssertEqual([navigatePath], prefetch.prefetched)
    }
    
    func test_action_shouldBeTriggered() {
        
        let action = ActionDummy()
        let button = Button(text: "Trigger Action", action: action)
        let context = BeagleContextSpy()
        
        let view = button.toView(context: context, dependencies: dependencies)
        (view as? Button.BeagleUIButton)?.triggerAction()
        
        XCTAssertEqual(context.actionCalled as? ActionDummy, action)
    }
}

final class ThemeSpy: Theme {
    
    private(set) var styledView: UIView?
    private(set) var styleApplied: String?
    
    func applyStyle<T>(for view: T, withId id: String) where T: UIView {
        styledView = view
        styleApplied = id
    }
}

final class BeaglePrefetchHelpingSpy: BeaglePrefetchHelping {
    func prefetchComponent(newPath: Navigate.NewPath) {
        prefetched.append(newPath.path)
    }
    
    func dequeueComponent(path: String) -> BeagleScreenViewController {
        dequeued.append(path)
        return BeagleScreenViewController(viewModel: .init(screenType: .remote(path)))
    }
    
    
    private(set) var prefetched: [String] = []
    private(set) var dequeued: [String] = []
}
