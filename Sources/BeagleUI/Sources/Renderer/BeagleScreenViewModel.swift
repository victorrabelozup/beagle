//
//  Copyright © 26/12/19 Zup IT. All rights reserved.
//

import UIKit

public class BeagleScreenViewModel {

    // MARK: ScreenType

    let screenType: ScreenType

    public enum ScreenType {
        case remote(String, fallback: Screen?)
        case declarative(Screen)
    }

    // MARK: State

    private(set) var state: State {
        didSet { didChangeState() }
    }
    
    private(set) var screen: Screen?

    public enum State {
        case loading
        case success
        case failure(Request.Error)
        case rendered
    }

    // MARK: Dependencies

    var dependencies: Dependencies

    public typealias Dependencies =
        DependencyActionExecutor
        & DependencyNetwork
        & RenderableDependencies

    // MARK: Delegate and Observer

    public weak var delegate: BeagleScreenDelegate?

    public weak var stateObserver: BeagleScreenStateObserver? {
        didSet { stateObserver?.didChangeState(state) }
    }

    // MARK: Init

    public init(
        screenType: ScreenType,
        dependencies: Dependencies = Beagle.dependencies,
        delegate: BeagleScreenDelegate? = nil
    ) {
        self.screenType = screenType
        self.dependencies = dependencies
        self.delegate = delegate

        switch screenType {
        case .declarative(let screen):
            self.screen = screen
            state = .success
        case .remote(let url, _):
            state = .loading
            loadScreenFromUrl(url)
        }
    }

    // MARK: Core

    func loadScreenFromUrl(_ url: String) {
        if let cached = dependencies.cacheManager.dequeueComponent(path: url) {
            handleSuccess(cached)
            return
        }
        
        state = .loading

        dependencies.network.fetchComponent(url: url) {
            [weak self] result in guard let self = self else { return }
            
            switch result {
            case .success(let component):
                self.handleSuccess(component)
            case .failure(let error):
                self.handleFailure(error)
            }
        }
    }
    
    func didRenderComponent() {
        state = .rendered
    }

    func handleError(_ error: Request.Error) {
        delegate?.beagleScreen(viewModel: self, didFailToLoadWithError: error)
    }
    
    // MARK: - Private
    
    private func handleSuccess(_ component: ServerDrivenComponent) {
        screen = component.toScreen()
        state = .success
    }
    
    private func handleFailure(_ error: Request.Error) {
        if case let .remote(_, screen) = self.screenType {
            self.screen = screen
        }
        self.state = .failure(error)
    }

    private func didChangeState() {
        stateObserver?.didChangeState(state)

        guard case .failure(let error) = state else { return }

        handleError(error)
    }
}

// MARK: - Delegate and Observer

public protocol BeagleScreenDelegate: AnyObject {
    typealias ViewModel = BeagleScreenViewModel

    func beagleScreen(
        viewModel: ViewModel,
        didFailToLoadWithError error: Request.Error
    )
}

public protocol BeagleScreenStateObserver: AnyObject {
    typealias ViewModel = BeagleScreenViewModel

    func didChangeState(_ state: ViewModel.State)
}
