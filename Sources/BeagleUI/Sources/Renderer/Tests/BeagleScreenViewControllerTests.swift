//
//  Copyright © 25/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleScreenViewControllerTests: XCTestCase {
    
    func test_onViewDidLoad_backGroundColorShouldBeSetToWhite() {
        // Given
        let widget = SimpleWidget()
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(widget.content.toScreen())
        ))
        
        // When
        sut.viewDidLoad()
        
        // Then

        // TODO: uncomment this when using Xcode > 10.3 (which will support iOS 13)
        // if #available(iOS 13.0, *) {
        //    XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        // } else {
            XCTAssertEqual(sut.view.backgroundColor, .white)
        // }
    }
    
    func test_onViewDidLayoutSubviews_shouldApplyYogaLayout() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()

        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(WidgetDummy().toScreen()),
            dependencies: BeagleScreenDependencies(
                flex: flexSpy
            )
        ))
        
        // When
        _ = sut.view
        sut.viewWillAppear(false)
        sut.viewDidLayoutSubviews()
        
        // Then
        XCTAssertEqual(flexSpy.applyYogaLayoutCallCount, 2)
    }
    
    func test_onViewWillAppear_navigationBarShouldBeHidden() {
        // Given
        let widget = SimpleWidget()
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(widget.content.toScreen())
        ))
        let navigation = UINavigationController(rootViewController: sut)
        
        // When
        sut.viewWillAppear(false)
        
        // Then
        XCTAssertTrue(navigation.isNavigationBarHidden)
    }
    
    func test_whenLoadScreenFails_itShouldCall_didFailToLoadWithError_onDelegate() {
        // Given
        let url = "www.something.com"
        let loaderStub = RemoteConnectorStub(
            loadWidgetResult: .failure(.emptyData)
        )
        
        let delegateSpy = BeagleScreenDelegateSpy()
        
        _ = BeagleScreenViewController(viewModel: .init(
            screenType: .remote(url),
            dependencies: BeagleScreenDependencies(
                remoteConnector: loaderStub
            ),
            delegate: delegateSpy
        ))
        
        // Then
        XCTAssertTrue(delegateSpy.didFailToLoadWithErrorCalled)
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

        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .remote("www.something.com"),
            dependencies: dependencies
        ))

        assertSnapshotImage(sut)
    }
}

// MARK: - Testing Helpers

struct SimpleWidget {
    var content = FlexSingleWidget(child:
        Text("Mock")
    )
}

struct BeagleScreenDependencies: BeagleScreenViewModel.Dependencies {
    var actionExecutor: ActionExecutor
    var flex: FlexViewConfiguratorProtocol
    var remoteConnector: RemoteConnector
    var theme: Theme
    var validatorProvider: ValidatorProvider?
    var appBundle: Bundle

    init(
        actionExecutor: ActionExecutor = ActionExecutorDummy(),
        flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy(),
        remoteConnector: RemoteConnector = RemoteConnectorDummy(),
        theme: Theme = AppThemeDummy(),
        validatorProvider: ValidatorProvider = ValidatorProviding(),
        appBundle: Bundle = Bundle(for: ImageTests.self)
    ) {
        self.actionExecutor = actionExecutor
        self.flex = flex
        self.remoteConnector = remoteConnector
        self.theme = theme
        self.validatorProvider = validatorProvider
        self.appBundle = appBundle
    }
}

final class RemoteConnectorDummy: RemoteConnector {
    func fetchWidget(from url: String, completion: @escaping (Result<Widget, RemoteConnector.Error>) -> Void) {}
    func submitForm(action: String, method: Form.MethodType, values: [String: String], completion: @escaping (Result<Action, RemoteConnector.Error>) -> Void) {}
}

final class FlexViewConfiguratorDummy: FlexViewConfiguratorProtocol {
    func setupFlex(_ flex: Flex, for view: UIView) {}
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {}
    func enableYoga(_ enable: Bool, for view: UIView) {}
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
    
    func submitForm(action: String, method: Form.MethodType, values: [String: String], completion: @escaping (Result<Action, RemoteConnectorError>) -> Void) {
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

final class BeagleScreenDelegateSpy: BeagleScreenDelegate {
    
    private(set) var didFailToLoadWithErrorCalled = false
    private(set) var viewModel: BeagleScreenViewModel?
    private(set) var errorPassed: RemoteConnectorError?
    
    func beagleScreen(viewModel: BeagleScreenViewModel, didFailToLoadWithError error: RemoteConnectorError) {
        didFailToLoadWithErrorCalled = true
        self.viewModel = viewModel
        errorPassed = error
    }
}
