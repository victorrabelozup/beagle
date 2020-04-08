/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import XCTest
@testable import BeagleUI
import SnapshotTesting

final class TouchableTests: XCTestCase {
    
    func testInitFromDecoder() throws {
        let component: Touchable = try componentFromJsonFile(fileName: "TouchableDecoderTest")
        assertSnapshot(matching: component, as: .dump)
    }

    func testTouchableView() throws {
        let touchable = Touchable(action: Navigate.popView, child: Text("Touchable"))
        let view = touchable.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())

        assertSnapshotImage(view, size: CGSize(width: 100, height: 80))
    }
    
    func testIfAnalyticsClickAndActionShouldBeTriggered() {
        // Given
        let component = SimpleComponent()
        let context = BeagleContextSpy()
        let analyticsExecutorSpy = AnalyticsExecutorSpy()
        let actionExecutorSpy = ActionExecutorSpy()
        let dependencies = BeagleScreenDependencies(
            actionExecutor: actionExecutorSpy,
            analytics: analyticsExecutorSpy
        )
        
        let controller = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: dependencies
        ))
        
        let navigationController = UINavigationController(rootViewController: controller)
        guard let sut = navigationController.viewControllers.first as? BeagleScreenViewController else {
            XCTFail("Could not find `BeagleScreenViewController`.")
            return
        }
        
        let actionDummy = ActionDummy()
        let analyticsAction = AnalyticsClick(category: "some category")
        let touchable = Touchable(action: actionDummy, clickAnalyticsEvent: analyticsAction, child: Text("mocked text"))
        let view = touchable.toView(context: context, dependencies: dependencies)
        
        sut.register(events: [.action(actionDummy), .analytics(analyticsAction)], inView: view)
        
        let gesture = view.gestureRecognizers?.first { $0 is EventsGestureRecognizer }
    
        guard let eventsGestureRecognizer = gesture as? EventsGestureRecognizer else {
            XCTFail("Could not find `EventsGestureRecognizer`")
            return
        }
                
        // When
        sut.handleGestureRecognizer(eventsGestureRecognizer)
                
        // Then
        XCTAssert(context.didCallRegisterEvents)
        XCTAssertTrue(analyticsExecutorSpy.didTrackEventOnClick)
        XCTAssertTrue(actionExecutorSpy.didCallDoAction)
    }
}
