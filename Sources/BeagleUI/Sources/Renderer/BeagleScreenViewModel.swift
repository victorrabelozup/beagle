//
//  Copyright © 26/12/19 Zup IT. All rights reserved.
//

import UIKit

public class BeagleScreenViewModel {

    // MARK: ScreenType

    let screenType: ScreenType

    public enum ScreenType {
        case remote(String)
        case declarative(ScreenWidget)
    }

    // MARK: State

    private(set) var state: State {
        didSet { didChangeState() }
    }
    
    private(set) var screen: ScreenWidget?

    public enum State {
        case loading
        case success
        case failure(RemoteConnectorError)
        case rendered
    }

    // MARK: Dependencies

    var dependencies: Dependencies

    public typealias Dependencies =
        DependencyActionExecutor
        & DependencyRemoteConnector
        & Renderable.Dependencies

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
        case .remote(let url):
            state = .loading
            loadScreenFromUrl(url)
        }
    }

    // MARK: Core

    func loadScreenFromUrl(_ url: String) {
        state = .loading

        dependencies.remoteConnector.fetchWidget(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let widget):
                self.screen = widget.toScreen()
                self.state = .success
            case .failure(let error):
                self.state = .failure(error)
            }
        }
    }
    
    func didRenderWidget() {
        state = .rendered
    }

    func handleError(_ error: RemoteConnectorError) {
        delegate?.beagleScreen(viewModel: self, didFailToLoadWithError: error)
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
        didFailToLoadWithError error: RemoteConnectorError
    )
}

public protocol BeagleScreenStateObserver: AnyObject {
    typealias ViewModel = BeagleScreenViewModel

    func didChangeState(_ state: ViewModel.State)
}
