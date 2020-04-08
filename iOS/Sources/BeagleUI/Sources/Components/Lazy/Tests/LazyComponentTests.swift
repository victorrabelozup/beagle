/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import SnapshotTesting
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
        _ = lazyComponent.toView(context: context, dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(context.didCallLazyLoad)
    }
    
    func test_loadUnknowComponent_shouldRenderTheError() {
        let lazyComponent = LazyComponent(path: "unknow-widget", initialState: Text("Loading..."))
        let size = CGSize(width: 300, height: 75)
        let network = LazyNetworkStub()
        let dependecies = BeagleDependencies()
        dependecies.network = network
        
        let screen = BeagleScreenViewController(
            viewModel: .init(
                screenType: .declarative(lazyComponent.toScreen()),
                dependencies: dependecies
            )
        )
        
        assertSnapshotImage(screen, size: size)
        network.componentCompletion?(.success(UnknownComponent(type: "LazyError")))
        assertSnapshotImage(screen, size: size)
    }
    
    func test_whenDecodingJson_thenItShouldReturnALazyComponent() throws {
        let component: LazyComponent = try componentFromJsonFile(fileName: "lazyComponent")
        assertSnapshot(matching: component, as: .dump)
    }
}

class LazyNetworkStub: Network {

    var componentCompletion: ((Result<ServerDrivenComponent, Request.Error>) -> Void)?
    var formCompletion: ((Result<Action, Request.Error>) -> Void)?
    var imageCompletion: ((Result<Data, Request.Error>) -> Void)?

    func fetchComponent(url: String, additionalData: RemoteScreenAdditionalData?, completion: @escaping (Result<ServerDrivenComponent, Request.Error>) -> Void) -> RequestToken? {
        componentCompletion = completion
        return nil
    }

    func submitForm(url: String, additionalData: RemoteScreenAdditionalData?, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        formCompletion = completion
        return nil
    }

    func fetchImage(url: String, additionalData: RemoteScreenAdditionalData?, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        imageCompletion = completion
        return nil
    }
}
