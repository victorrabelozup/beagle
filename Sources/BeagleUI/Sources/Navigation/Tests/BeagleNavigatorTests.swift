//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleNavigatorTests: XCTestCase {
    
    struct Prefetch: DependencyPreFetching {
        var preFetchHelper: BeaglePrefetchHelping = BeaglePreFetchHelper()
    }
    
    func test_openDeepLink_shouldNotPushANativeScreenToNavigationWhenDeepLinkHandlerItsNotSet() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.openDeepLink(.init(
            path: "https://example.com/screen.json"
        ))
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigation = UINavigationController(rootViewController: firstViewController)
        
        // When
        sut.navigate(action: action, context: context)
        
        //Then
        XCTAssert(navigation.viewControllers.count == 1)
    }

    func test_swapView_shouldReplaceNavigationStack() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.swapView(.init(path: "https://example.com/screen.json"))
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let context = DummyBeagleContext(viewController: secondViewController)
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigation.viewControllers.count == 1)
        XCTAssert(navigation.viewControllers.last is BeagleScreenViewController)
    }

    func test_addView_shouldPushScreenInNavigation() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.addView(.init(path: "https://example.com/screen.json"))
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigation = UINavigationController(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigation.viewControllers.count == 2)
        XCTAssert(navigation.viewControllers.last is BeagleScreenViewController)
    }

    func test_finishView_shouldDismissNavigation() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.finishView
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigationSpy.dismissViewControllerCalled)
    }

    func test_popView_shouldPopNavigationScreen() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.popView
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let thirdViewController = UIViewController()
        let context = DummyBeagleContext(viewController: thirdViewController)
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController, thirdViewController]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigation.viewControllers.count == 2)
    }

    func test_popToView_shouldNotNavigateWhenScreenIsNotFound() {
        // Given
        let screenURL1 = "https://example.com/screen1.json"
        let screenURL2 = "https://example.com/screen2.json"
        let screenURL3 = "https://example.com/screen3.json"
        let sut = BeagleNavigator(dependencies: Prefetch())
        let component = SimpleComponent()
        let action = Navigate.popToView(screenURL1)
        let vc1 = beagleViewController(screen: .declarative(component.content.toScreen()))
        let vc2 = beagleViewController(screen: .remote(screenURL2))
        let vc3 = beagleViewController(screen: .remote(screenURL3))
        let vc4 = UIViewController()
        let context = DummyBeagleContext(viewController: vc4)
        let navigation = UINavigationController()
        navigation.viewControllers = [vc1, vc2, vc3, vc4]

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigation.viewControllers.count == 4)
        XCTAssert(navigation.viewControllers.last == vc4)
    }

    func test_popToView_shouldRemoveFromStackScreensAfterTargetScreen() {
        // Given
        let screenURL1 = "https://example.com/screen1.json"
        let screenURL2 = "https://example.com/screen2.json"
        let screenURL3 = "https://example.com/screen3.json"
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.popToView(screenURL2)
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
        XCTAssert(navigation.viewControllers.count == 2)
        XCTAssert(navigation.viewControllers.last == vc2)
    }

    func test_presentView_shouldPresentTheScreen() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let action = Navigate.presentView(.init(path: "https://example.com/screen.json"))
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)

        // When
        sut.navigate(action: action, context: context)

        // Then
        XCTAssert(navigationSpy.presentViewControllerCalled)
    }
    
    func test_openDeepLink_shouldPushANativeScreenWithData() {
        // Given
        let sut = BeagleNavigator(dependencies: Prefetch())
        let data = ["uma": "uma", "dois": "duas"]
        let path = "https://example.com/screen.json"
        let action = Navigate.openDeepLink(.init(path: path, data: data))
        let firstViewController = UIViewController()
        let context = DummyBeagleContext(viewController: firstViewController)
        let navigation = UINavigationController(rootViewController: firstViewController)
        
        let dependencieManager = BeagleDependencies(appName: "demo")
        let deepLinkSpy = DeepLinkHandlerSpy()
        dependencieManager.deepLinkHandler = deepLinkSpy
        Beagle.dependencies = dependencieManager
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }
        
        // When
        sut.navigate(action: action, context: context)
        
        //Then
        XCTAssert(navigation.viewControllers.count == 2)
        XCTAssert(deepLinkSpy.calledData == data)
        XCTAssert(deepLinkSpy.calledPath == path)
    }

    private func beagleViewController(screen: BeagleScreenViewModel.ScreenType) -> BeagleScreenViewController {
        return BeagleScreenViewController(viewModel: .init(
            screenType: screen,
            dependencies: BeagleScreenDependencies()
        ))
    }
}

class DeepLinkHandlerSpy: BeagleDeepLinkScreenManaging {
    var calledPath: String?
    var calledData: [String: String]?
    
    func getNaviteScreen(with path: String, data: [String: String]?) throws -> UIViewController {
        calledData = data
        calledPath = path
        return UIViewController()
    }
}

class DummyBeagleContext: BeagleContext {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    var screenController: UIViewController { return viewController }
    
    func register(action: Action, inView view: UIView) {}
    func register(form: Form, formView: UIView, submitView: UIView, validatorHandler validator: ValidatorProvider?) {}
    func register(formSubmitEnabledWidget: Widget?, formSubmitDisabledWidget: Widget?) {}
    func lazyLoad(url: String, initialState: UIView) {}
    func doAction(_ action: Action, sender: Any) {}
}
