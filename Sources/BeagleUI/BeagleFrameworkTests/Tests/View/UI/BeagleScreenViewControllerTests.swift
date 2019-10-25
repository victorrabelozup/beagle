//
//  BeagleScreenViewControllerTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleScreenViewControllerTests: XCTestCase {

    func test_publicInit_shouldSetupDependenciesProperly() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        
        // When
        let sut = BeagleScreenViewController(screenType: .declarative(screenMock))
        let mirror = Mirror(reflecting: sut)
        let screenType = mirror.firstChild(of: BeagleScreenViewController.ScreenType.self)
        let flexConfigurator = mirror.firstChild(of: FlexViewConfigurator.self)
        let viewBuilder = mirror.firstChild(of: BeagleViewBuilding.self)
        let serverDrivenScreenLoader = mirror.firstChild(of: ServerDrivenScreenLoading.self)
        
        // Then
        XCTAssertNotNil(screenType)
        XCTAssertNotNil(flexConfigurator)
        XCTAssertNotNil(viewBuilder)
        XCTAssertNotNil(serverDrivenScreenLoader)
    }
    
    func test_onViewDidLoad_backGroundColorShouldBeSetToWhite() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(screenMock),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy()
        )
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.view.backgroundColor, .white, "Expected `white`, but got \(String(describing: sut.view.backgroundColor)).")
    }
    
    func test_whenLoadingADeclativeView_itShouldSetupTheWidgetViewProperly() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        
        let viewBuilderSpy = BeagleViewBuilderSpy()
        let viewToReturn = UIView()
        viewToReturn.tag = 1234
        viewBuilderSpy.viewToReturn = viewToReturn
        
        let sut = BeagleScreenViewController(
            screenType: .declarative(screenMock),
            flexConfigurator: flexConfiguratorSpy,
            viewBuilder: viewBuilderSpy,
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy()
        )
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewBuilderSpy.buildFromRootWidgetCalled, "`buildFromRootWidget` should have been called.")
        XCTAssertNotNil(sut.view.viewWithTag(viewToReturn.tag), "The widgetView should be present on the view hierarchy.")
        XCTAssertTrue(flexConfiguratorSpy.applyYogaLayoutCalled, "`applyYogaLayout` should have been called.")
    }
    
    func test_whenLoadScreenFails_itShouldCall_didFailToLoadWithError_onDelegate() {
        // Given
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }
        
        let serverDrivenScreenLoaderStub = ServerDrivenScreenLoaderStub(
            resultToReturn: .failure(.fetchError(.emptyData))
        )
        
        let delegateSpy = BeagleScreenViewControllerDelegateSpy()
        
        let sut = BeagleScreenViewController(
            screenType: .remote(url),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenScreenLoaderStub
        )
        sut.delegate = delegateSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(delegateSpy.didFailToLoadWithErrorCalled, "`didFailToLoadWithError` should have been called.")
    }
    
    func test_whenLoadScreenSucceeds_itShouldSetupTheViewWithTheResult() {
        // Given
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }
        
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        
        let viewToReturn = UIView()
        viewToReturn.tag = 1234
        
        let serverDrivenScreenLoaderStub = ServerDrivenScreenLoaderStub(
            resultToReturn: .success(viewToReturn)
        )
        
        let sut = BeagleScreenViewController(
            screenType: .remote(url),
            flexConfigurator: flexConfiguratorSpy,
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenScreenLoaderStub
        )
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(sut.view.viewWithTag(viewToReturn.tag), "The widgetView should be present on the view hierarchy.")
        XCTAssertTrue(flexConfiguratorSpy.applyYogaLayoutCalled, "`applyYogaLayout` should have been called.")
    }
    
}

// MARK: - Testing Helpers

struct ServerDrivenScreenMock: Screen {
    var content: Widget {
        FlexSingleWidget {
            Text("Mock")
        }
    }
}

final class ServerDrivenScreenLoaderDummy: ServerDrivenScreenLoader {
    func loadScreen(from url: URL, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {}
}

final class FlexViewConfiguratorDummy: FlexViewConfiguratorProtocol {
    func setupFlex(_ flex: Flex, for view: UIView) {}
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {}
    func enableYoga(_ enable: Bool, for view: UIView) {}
}

final class ServerDrivenScreenLoaderStub: ServerDrivenScreenLoader {
    
    let resultToReturn: Result<UIView, ServerDrivenScreenLoaderError>
    init(resultToReturn: Result<UIView, ServerDrivenScreenLoaderError>) {
        self.resultToReturn = resultToReturn
    }
    
    func loadScreen(from url: URL, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {
        completion(resultToReturn)
    }
    
}

final class BeagleScreenViewControllerDelegateSpy: BeagleScreenViewControllerDelegate {
    
    private(set) var didFailToLoadWithErrorCalled = false
    private(set) var controllerPassed: BeagleScreenViewController?
    private(set) var errorPassed: Error?
    func beagleScreenViewController(_ controller: BeagleScreenViewController, didFailToLoadWithError error: Error) {
        didFailToLoadWithErrorCalled = true
        controllerPassed = controller
        errorPassed = error
    }
    
}
