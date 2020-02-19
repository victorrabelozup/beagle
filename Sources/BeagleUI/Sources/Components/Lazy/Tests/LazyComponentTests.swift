//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyComponentTests: XCTestCase {
    
    func test_initWithInitialStateBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let sut = LazyComponent(
            path: "component",
            initialState: Text("text")
        )

        // Then
        XCTAssert(sut.path == "component")
        XCTAssert(sut.initialState is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let lazyComponent = LazyComponent(path: "path", initialState: ComponentDummy())
        let context = BeagleContextSpy()
        
        // When
        _ = lazyComponent.toView(context: context, dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(context.didCallLazyLoad)
    }
    
    func test_loadUnknowComponent_shouldRenderTheError() {
        let lazyComponent = LazyComponent(path: "unknow-widget", initialState: Text("Loading..."))
        let network = LazyNetworkStub()
        let dependecies = BeagleDependencies()
        dependecies.network = network
        
        let screen = BeagleScreenViewController(
            viewModel: .init(
                screenType: .declarative(lazyComponent.toScreen()),
                dependencies: dependecies
            )
        )
        
        assertSnapshotImage(screen, size: CGSize(width: 300, height: 75))
        network.componentCompletion?(.success(AnyComponent(value: "LazyError")))
        
        assertSnapshotImage(screen, size: CGSize(width: 300, height: 75))
    }
}

class LazyNetworkStub: Network {
    
    var componentCompletion: ((Result<ServerDrivenComponent, Request.Error>) -> Void)?
    var formCompletion: ((Result<Action, Request.Error>) -> Void)?
    var imageCompletion: ((Result<Data, Request.Error>) -> Void)?
    
    func fetchComponent(url: String, completion: @escaping (Result<ServerDrivenComponent, Request.Error>) -> Void) -> RequestToken? {
        componentCompletion = completion
        return nil
    }
    
    func submitForm(url: String, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        formCompletion = completion
        return nil
    }
    
    func fetchImage(url: String, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        imageCompletion = completion
        return nil
    }
}
