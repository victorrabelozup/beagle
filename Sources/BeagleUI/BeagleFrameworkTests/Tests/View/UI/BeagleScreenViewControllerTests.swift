//
//  BeagleScreenViewControllerTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleScreenViewControllerTests: XCTestCase {
    
    func test_onViewDidLoad_backGroundColorShouldBeSetToWhite() {
        // Given
        let widget = SimpleWidget()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content)
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
        let flexSpy = FlexViewConfiguratorSpy()

        let sut = BeagleScreenViewController(
            screenType: .declarative(WidgetDummy()),
            dependencies: ScreenViewControllerDependencies(
                flex: flexSpy
            )
        )
        
        // When
        let _ = sut.view
        sut.viewDidLayoutSubviews()
        
        // Then
        XCTAssertEqual(flexSpy.applyYogaLayoutCallCount, 2)
    }
    
    func test_onViewWillAppear_navigationBarShouldBeHidden() {
        // Given
        let widget = SimpleWidget()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content)
        )
        let navigation = UINavigationController(rootViewController: sut)
        
        // When
        sut.viewWillAppear(false)
        
        // Then
        XCTAssertTrue(navigation.isNavigationBarHidden, "Expected navigation bar to be hidden")
    }
    
    func test_whenLoadScreenFails_itShouldCall_didFailToLoadWithError_onDelegate() {
        // Given
        let url = "www.something.com"
        let loaderStub = RemoteConnectorStub(
            loadWidgetResult: .failure(.emptyData)
        )
        
        let delegateSpy = BeagleScreenViewControllerDelegateSpy()
        
        let sut = BeagleScreenViewController(
            screenType: .remote(url),
            dependencies: ScreenViewControllerDependencies(
                remoteConnector: loaderStub
            )
        )
        sut.delegate = delegateSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(delegateSpy.didFailToLoadWithErrorCalled, "`didFailToLoadWithError` should have been called.")
    }
    
    func test_whenLoadScreenSucceeds_itShouldSetupTheViewWithTheResult() {
        // Given
        let viewToReturn = UIView()
        viewToReturn.tag = 1234

        let loaderStub = RemoteConnectorStub(
            loadWidgetResult: .success(SimpleWidget().content)
        )

        let dependencies = BeagleDependencies(appName: "TEST")
        dependencies.remoteConnector = loaderStub

        let sut = BeagleScreenViewController(
            screenType: .remote("www.something.com"),
            dependencies: dependencies
        )

        assertSnapshot(matching: sut, as: .image)
    }
    
}

// MARK: - Testing Helpers

struct SimpleWidget {
    var content = FlexSingleWidget {
        Text("Mock")
    }
}

struct ScreenViewControllerDependencies: BeagleScreenViewController.Dependencies {
    var actionExecutor: ActionExecutor = ActionExecutorDummy()
    var flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy()
    var rendererProvider: WidgetRendererProvider = WidgetRendererProviderDummy()
    var remoteConnector: RemoteConnector = RemoteConnectorDummy()
    var theme: Theme = AppThemeDummy()
    var validatorProvider: ValidatorProvider? = ValidatorProviding()
}

final class RemoteConnectorDummy: RemoteConnector {
    func fetchWidget(from url: String, completion: @escaping (Result<Widget, RemoteConnector.Error>) -> Void) {}
    func submitForm(action: String, method: Form.MethodType, values: [String : String], completion: @escaping (Result<Action, RemoteConnector.Error>) -> Void) {}
}

final class FlexViewConfiguratorDummy: FlexViewConfiguratorProtocol {
    func setupFlex(_ flex: Flex, for view: UIView) {}
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {}
    func enableYoga(_ enable: Bool, for view: UIView) {}
    func instrinsicSize(for view: UIView) -> CGSize { return .zero }
}

final class RemoteConnectorStub: RemoteConnector {

    let submitFormResult: Result<Action, RemoteConnectorError>?
    let loadWidgetResult: Result<Widget, RemoteConnectorError>?
    init(
        submitFormResult: Result<Action, RemoteConnectorError>? = nil,
        loadWidgetResult: Result<Widget, RemoteConnectorError>? = nil
    ) {
        self.submitFormResult = submitFormResult
        self.loadWidgetResult = loadWidgetResult
    }
    
    func submitForm(action: String, method: Form.MethodType, values: [String : String], completion: @escaping (Result<Action, RemoteConnectorError>) -> Void) {
        if let result = submitFormResult {
            completion(result)
        }
    }
    
    func fetchWidget(from url: String, completion: @escaping (Result<Widget, RemoteConnector.Error>) -> Void) {
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
