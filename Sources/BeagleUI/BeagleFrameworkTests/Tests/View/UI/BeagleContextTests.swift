//
//  BeagleContextTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleContextTests: XCTestCase {

    func test_registerAction_shouldAddGestureRecognizer() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(screenMock),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy()
        )
        let view = UILabel()
        let action = Navigate(type: .popView)
        
        // When
        sut.register(action: action, inView: view)
        
        // Then
        XCTAssertEqual(1, view.gestureRecognizers?.count)
        XCTAssertTrue(view.isUserInteractionEnabled)
    }
    
    func test_action_shouldBeTriggered() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        let controller = BeagleScreenViewController(
            screenType: .declarative(screenMock),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy()
        )
        
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: controller)
        
        guard let sut = navigationControllerSpy.viewControllers.first as? BeagleScreenViewController else {
            XCTFail("Could not find `BeagleScreenViewController`.")
            return
        }
        
        let view = UILabel()
        let action = Navigate(type: .popView)
        sut.register(action: action, inView: view)
        
        guard let actionGestureRecognizer = view.gestureRecognizers?.first as? ActionGestureRecognizer else {
            XCTFail("Could not find `ActionGestureRecognizer`.")
            return
        }
        
        // When
        sut.handleActionGesture(actionGestureRecognizer)
                
        // Then
        XCTAssertTrue(navigationControllerSpy.popViewControllerCalled)
    }
    
}

// MARK: - Testing Helpers

private class UINavigationControllerSpy: UINavigationController {
    private(set) var popViewControllerCalled = false
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        return super.popViewController(animated: animated)
    }
}
