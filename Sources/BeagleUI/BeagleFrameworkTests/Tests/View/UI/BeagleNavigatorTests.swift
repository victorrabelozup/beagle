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
    
    func test_actionWithoutPath_shouldNotNavigate() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .swapView)
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController]
        
        // When
        sut.navigate(action: action, source: secondViewController)
        
        // Then
        XCTAssertEqual(navigation.viewControllers, [firstViewController, secondViewController])
    }
    
    func test_openDeepLink_shouldNotPushANativeScreenToNavigationWhenDeepLinkHandlerItsNotSet() {
        // Given
        if !Beagle.didCallStart {
            Beagle.start()
        }
        let sut = BeagleNavigator()
        let action = Navigate(type: .openDeepLink, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let navigation = UINavigationController(rootViewController: firstViewController)
        
        // When
        sut.navigate(action: action, source: firstViewController)
        
        //Then
        XCTAssertEqual(1, navigation.viewControllers.count)
    }
    
    func test_swapView_shouldReplaceNavigationStack() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .swapView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController]
        if !Beagle.didCallStart {
            Beagle.start()
        }
        
        // When
        sut.navigate(action: action, source: secondViewController)
        
        // Then
        XCTAssertEqual(1, navigation.viewControllers.count)
        XCTAssertTrue(navigation.viewControllers.last is BeagleScreenViewController)
    }
    
    func test_addView_shouldPushScreenInNavigation() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .addView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let navigation = UINavigationController(rootViewController: firstViewController)
        if !Beagle.didCallStart {
            Beagle.start()
        }
                
        // When
        sut.navigate(action: action, source: firstViewController)
        
        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
        XCTAssertTrue(navigation.viewControllers.last is BeagleScreenViewController)
    }
    
    func test_finishView_shouldDismissNavigation() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .finishView)
        let firstViewController = UIViewController()
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)
        
        // When
        sut.navigate(action: action, source: firstViewController)
        
        // Then
        XCTAssertTrue(navigationSpy.dismissViewControllerCalled)
    }
    
    func test_popView_shouldPopNavigationScreen() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .popView)
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let thirdViewController = UIViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [firstViewController, secondViewController, thirdViewController]
                
        // When
        sut.navigate(action: action, source: thirdViewController)
        
        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
    }
    
    func test_popToView_shouldNotNavigateWhenScreenIsNotFound() {
        // Given
        guard
            let baseURL = URL(string: "https://example.com/"),
            let screenURL1 = URL(string: "screen1.json", relativeTo: baseURL),
            let screenURL2 = URL(string: "screen2.json", relativeTo: baseURL),
            let screenURL3 = URL(string: "screen3.json", relativeTo: baseURL) else {
                XCTFail("Failed to create screens URL")
                return
        }
        let sut = BeagleNavigator()
        let screenMock = ServerDrivenScreenMock()
        let action = Navigate(type: .popToView, path: screenURL1.absoluteString)
        let vc1 = beagleViewController(screen: .declarative(screenMock))
        let vc2 = beagleViewController(screen: .remote(screenURL2))
        let vc3 = beagleViewController(screen: .remote(screenURL3))
        let vc4 = UIViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [vc1, vc2, vc3, vc4]
                
        // When
        sut.navigate(action: action, source: vc4)
        
        // Then
        XCTAssertEqual(4, navigation.viewControllers.count)
        XCTAssertEqual(navigation.viewControllers.last, vc4)
    }
    
    func test_popToView_shouldRemoveFromStackScreensAfterTargetScreen() {
        // Given
        guard
            let baseURL = URL(string: "https://example.com/"),
            let screenURL1 = URL(string: "screen1.json", relativeTo: baseURL),
            let screenURL2 = URL(string: "screen2.json", relativeTo: baseURL),
            let screenURL3 = URL(string: "screen3.json", relativeTo: baseURL) else {
                XCTFail("Failed to create screens URL")
                return
        }
        let sut = BeagleNavigator()
        let action = Navigate(type: .popToView, path: screenURL2.absoluteString)
        let vc1 = beagleViewController(screen: .remote(screenURL1))
        let vc2 = beagleViewController(screen: .remote(screenURL2))
        let vc3 = beagleViewController(screen: .remote(screenURL3))
        let vc4 = UIViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [vc1, vc2, vc3, vc4]
                
        // When
        sut.navigate(action: action, source: vc4)
        
        // Then
        XCTAssertEqual(2, navigation.viewControllers.count)
        XCTAssertEqual(navigation.viewControllers.last, vc2)
    }
    
    func test_presentView_shouldPresentTheScreen() {
        // Given
        let sut = BeagleNavigator()
        let action = Navigate(type: .presentView, path: "https://example.com/screen.json")
        let firstViewController = UIViewController()
        let navigationSpy = UINavigationControllerSpy(rootViewController: firstViewController)
        if !Beagle.didCallStart {
            Beagle.start()
        }
        
        // When
        sut.navigate(action: action, source: firstViewController)
        
        // Then
        XCTAssertTrue(navigationSpy.presentViewControllerCalled)
    }
    
    private func beagleViewController(screen: BeagleScreenViewController.ScreenType) -> BeagleScreenViewController {
        return BeagleScreenViewController(
            screenType: screen,
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
    }
}
