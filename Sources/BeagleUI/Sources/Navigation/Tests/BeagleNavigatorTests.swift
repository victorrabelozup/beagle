//
//  BeagleNavigatorTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleNavigatorTests: XCTestCase {
    
    struct Prefetch: DependencyPreFetching {
        var preFetchHelper: BeaglePrefetchHelping = BeaglePreFetchHelper()
    }
    
    func test_actionWithoutPath_shouldNotNavigate() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .swapView)
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let context = DummyBeagleContext(viewController: secondViewController)
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController]
        
        // When
        sut.navigate(action: action, context: context)
        
        // Then
        XCTAssertEqual(navigation.viewControllers, [firstViewController, secondViewController])
    }
    
    func test_openDeepLink_shouldNotPushANativeScreenToNavigationWhenDeepLinkHandlerItsNotSet() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .openDeepLink, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigation = UINavigationController(rootViewController: firstViewController)
        
        // When
        sut.navigate(action: action, context: context)
        
        //Then
        XCTAssertEqual(1, navigation.viewControllers.count)
    }

    func test_swapView_shouldReplaceNavigationStack() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .swapView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let context = DummyBeagleContext(viewController: secondViewController)
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertEqual(1, navigation.viewControllers.count)
        XCTAssertTrue(navigation.viewControllers.last is BeagleScreenViewController)
    }

    func test_addView_shouldPushScreenInNavigation() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .addView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigation = UINavigationController(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
        XCTAssertTrue(navigation.viewControllers.last is BeagleScreenViewController)
    }

    func test_finishView_shouldDismissNavigation() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .finishView)
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertTrue(navigationSpy.dismissViewControllerCalled)
    }

    func test_popView_shouldPopNavigationScreen() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .popView)
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let thirdViewController = UIViewController()
        let context = DummyBeagleContext(viewController: thirdViewController)
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController, thirdViewController]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
    }

    func test_popToView_shouldNotNavigateWhenScreenIsNotFound() {
        // Given
        let screenURL1 = "https://example.com/screen1.json"
        let screenURL2 = "https://example.com/screen2.json"
        let screenURL3 = "https://example.com/screen3.json"
        let sut = BeagleNavigator(dependencies: Prefetch())
        let widget = SimpleWidget()
        let action = Navigate(type: .popToView, path: screenURL1)
        let vc1 = beagleViewController(screen: .declarative(widget.content))
        let vc2 = beagleViewController(screen: .remote(screenURL2))
        let vc3 = beagleViewController(screen: .remote(screenURL3))
        let vc4 = UIViewController()
        let context = DummyBeagleContext(viewController: vc4)
        let navigation = UINavigationController()
        navigation.viewControllers = [vc1, vc2, vc3, vc4]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertEqual(4, navigation.viewControllers.count)
        XCTAssertEqual(navigation.viewControllers.last, vc4)
    }

    func test_popToView_shouldRemoveFromStackScreensAfterTargetScreen() {
        // Given
        let screenURL1 = "https://example.com/screen1.json"
        let screenURL2 = "https://example.com/screen2.json"
        let screenURL3 = "https://example.com/screen3.json"
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .popToView, path: screenURL2)
        let vc1 = beagleViewController(screen: .remote(screenURL1))
        let vc2 = beagleViewController(screen: .remote(screenURL2))
        let vc3 = beagleViewController(screen: .remote(screenURL3))
        let vc4 = UIViewController()
        let context = DummyBeagleContext(viewController: vc4)
        let navigation = UINavigationController()
        navigation.viewControllers = [vc1, vc2, vc3, vc4]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
        XCTAssertEqual(navigation.viewControllers.last, vc2)
    }

    func test_presentView_shouldPresentTheScreen() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate(type: .presentView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssertTrue(navigationSpy.presentViewControllerCalled)
    }

    private func beagleViewController(screen: BeagleScreenViewModel.ScreenType) -> BeagleScreenViewController {
        return BeagleScreenViewController(viewModel: .init(
            screenType: screen,
            dependencies: ScreenViewControllerDependencies()
        ))
    }
}

class DummyBeagleContext: BeagleContext {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    var screenController: UIViewController { viewController }
    
    func register(action: Action, inView view: UIView) {}
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {}
    func lazyLoad(url: String, initialState: UIView) {}
    func doAction(_ action: Action, sender: Any) {}
}
