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
        let networkStub = NetworkStub(
            widgetResult: .failure(.networkError(NSError()))
        )
        
        let delegateSpy = BeagleScreenDelegateSpy()
        
        _ = BeagleScreenViewController(viewModel: .init(
            screenType: .remote(url),
            dependencies: BeagleScreenDependencies(
                network: networkStub
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

        let loaderStub = NetworkStub(
            widgetResult: .success(SimpleWidget().content)
        )

        let dependencies = BeagleDependencies(appName: "TEST")
        dependencies.network = loaderStub

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
    var network: Network
    var theme: Theme
    var validatorProvider: ValidatorProvider?
    var preFetchHelper: BeaglePrefetchHelping
    var appBundle: Bundle

    init(
        actionExecutor: ActionExecutor = ActionExecutorDummy(),
        flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy(),
        network: Network = NetworkDummy(),
        theme: Theme = AppThemeDummy(),
        validatorProvider: ValidatorProvider = ValidatorProviding(),
        preFetchHelper: BeaglePrefetchHelping = BeaglePreFetchHelper(),
        appBundle: Bundle = Bundle(for: ImageTests.self)
    ) {
        self.actionExecutor = actionExecutor
        self.flex = flex
        self.network = network
        self.theme = theme
        self.validatorProvider = validatorProvider
        self.preFetchHelper = preFetchHelper
        self.appBundle = appBundle
    }
}

final class NetworkDummy: Network {
    func fetchWidget(url: String, completion: @escaping (Result<Widget, Request.Error>) -> Void) -> RequestToken? {
        return nil
    }

    func submitForm(url: String, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        return nil
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        return nil
    }
}

final class FlexViewConfiguratorDummy: FlexViewConfiguratorProtocol {
    func setupFlex(_ flex: Flex, for view: UIView) {}
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {}
    func enableYoga(_ enable: Bool, for view: UIView) {}
}

struct NetworkStub: Network {
    let widgetResult: Result<Widget, Request.Error>?
    let formResult: Result<Action, Request.Error>?
    let imageResult: Result<Data, Request.Error>?

    init(
        widgetResult: Result<Widget, Request.Error>? = nil,
        formResult: Result<Action, Request.Error>? = nil,
        imageResult: Result<Data, Request.Error>? = nil
    ) {
        self.widgetResult = widgetResult
        self.formResult = formResult
        self.imageResult = imageResult
    }

    func fetchWidget(url: String, completion: @escaping (Result<Widget, Request.Error>) -> Void) -> RequestToken? {
        if let result = widgetResult {
            completion(result)
        }
        return nil
    }

    func submitForm(url: String, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        if let result = formResult {
            completion(result)
        }
        return nil
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        if let result = imageResult {
            completion(result)
        }
        return nil
    }
}

struct NetworkDispatcherStub: NetworkClient {
    let result: NetworkClient.Result

    func executeRequest(_ request: Request, completion: @escaping RequestCompletion) -> RequestToken? {
        completion(result)
        return nil
    }
}

final class BeagleScreenDelegateSpy: BeagleScreenDelegate {
    
    private(set) var didFailToLoadWithErrorCalled = false
    private(set) var viewModel: BeagleScreenViewModel?
    private(set) var errorPassed: Request.Error?
    
    func beagleScreen(viewModel: BeagleScreenViewModel, didFailToLoadWithError error: Request.Error) {
        didFailToLoadWithErrorCalled = true
        self.viewModel = viewModel
        errorPassed = error
    }
}
