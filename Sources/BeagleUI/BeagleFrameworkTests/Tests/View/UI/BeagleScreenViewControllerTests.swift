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
        let widget = ServerDrivenWidgetMock()
        
        // When
        let sut = BeagleScreenViewController(screenType: .declarative(widget.content))
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
        let widget = ServerDrivenWidgetMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        
        // When
        sut.viewDidLoad()
        
        // Then
        if #available(iOS 13.0, *) {
            XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        } else {
            XCTAssertEqual(sut.view.backgroundColor, .white)
        }
    }
    
    func test_onViewDidLayoutSubviews_shouldApplyYogaLayout() {
        // Given
        let flexConfigurator = FlexViewConfiguratorSpy()
        let sut = BeagleScreenViewController(
            screenType: .declarative(WidgetDummy()),
            flexConfigurator: flexConfigurator,
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        
        // When
        let _ = sut.view
        sut.viewDidLayoutSubviews()
        
        // Then
        XCTAssertEqual(flexConfigurator.applyYogaLayoutCallCount, 2)
    }
    
    func test_onViewWillAppear_navigationBarShouldBeHidden() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        let navigation = UINavigationController(rootViewController: sut)
        
        // When
        sut.viewWillAppear(false)
        
        // Then
        XCTAssertTrue(navigation.isNavigationBarHidden, "Expected navigation bar to be hidden")
    }
    
    func test_whenLoadingADeclativeView_itShouldSetupTheWidgetViewProperly() {
        // Given
        let widget = ServerDrivenWidgetMock()
        
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        
        let viewBuilderSpy = BeagleViewBuilderSpy()
        let viewToReturn = UIView()
        viewToReturn.tag = 1234
        viewBuilderSpy.viewToReturn = viewToReturn
        
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: flexConfiguratorSpy,
            viewBuilder: viewBuilderSpy,
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
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
        let url = "www.something.com"
        let serverDrivenScreenLoaderStub = ServerDrivenScreenLoaderStub(
            loadScreenResult: .failure(.fetchError(.emptyData))
        )
        
        let delegateSpy = BeagleScreenViewControllerDelegateSpy()
        
        let sut = BeagleScreenViewController(
            screenType: .remote(url),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenScreenLoaderStub,
            actionExecutor: ActionExecutorDummy()
        )
        sut.delegate = delegateSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(delegateSpy.didFailToLoadWithErrorCalled, "`didFailToLoadWithError` should have been called.")
    }
    
    func test_whenLoadScreenSucceeds_itShouldSetupTheViewWithTheResult() {
        // Given
        let url = "www.something.com"
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        
        let viewToReturn = UIView()
        viewToReturn.tag = 1234
        
        let serverDrivenScreenLoaderStub = ServerDrivenScreenLoaderStub(
            loadScreenResult: .success(viewToReturn)
        )
        
        let sut = BeagleScreenViewController(
            screenType: .remote(url),
            flexConfigurator: flexConfiguratorSpy,
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenScreenLoaderStub,
            actionExecutor: ActionExecutorDummy()
        )
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(sut.view.viewWithTag(viewToReturn.tag), "The widgetView should be present on the view hierarchy.")
        XCTAssertTrue(flexConfiguratorSpy.applyYogaLayoutCalled, "`applyYogaLayout` should have been called.")
    }
    
}

// MARK: - Testing Helpers

struct ServerDrivenWidgetMock {
    var content = FlexSingleWidget {
        Text("Mock")
    }
}

final class ServerDrivenScreenLoaderDummy: ServerDrivenScreenLoader {
    func loadScreen(from url: String, context: BeagleContext, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {}
    func submitForm(action: String, method: Form.MethodType, values: [String : String], completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void) {}
    func loadWidget(from url: String, completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void) {}
}

final class FlexViewConfiguratorDummy: FlexViewConfiguratorProtocol {
    func setupFlex(_ flex: Flex, for view: UIView) {}
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {}
    func enableYoga(_ enable: Bool, for view: UIView) {}
    func instrinsicSize(for view: UIView) -> CGSize { return .zero }
}

final class ServerDrivenScreenLoaderStub: ServerDrivenScreenLoader {
    
    let loadScreenResult: Result<UIView, ServerDrivenScreenLoaderError>?
    let submitFormResult: Result<Action, ServerDrivenWidgetFetcherError>?
    let loadWidgetResult: Result<Widget, ServerDrivenWidgetFetcherError>?
    init(
        loadScreenResult: Result<UIView, ServerDrivenScreenLoaderError>? = nil,
        submitFormResult: Result<Action, ServerDrivenWidgetFetcherError>? = nil,
        loadWidgetResult: Result<Widget, ServerDrivenWidgetFetcherError>? = nil
    ) {
        self.loadScreenResult = loadScreenResult
        self.submitFormResult = submitFormResult
        self.loadWidgetResult = loadWidgetResult
    }
    
    func loadScreen(from url: String, context: BeagleContext, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {
        if let result = loadScreenResult {
            completion(result)
        }
    }
    
    func submitForm(action: String, method: Form.MethodType, values: [String : String], completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void) {
        if let result = submitFormResult {
            completion(result)
        }
    }
    
    func loadWidget(from url: String, completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void) {
        if let result = loadWidgetResult {
            completion(result)
        }
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
