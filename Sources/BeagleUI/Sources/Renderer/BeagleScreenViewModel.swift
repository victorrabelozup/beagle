//
//  Copyright © 26/12/19 Zup IT. All rights reserved.
//

import Foundation

public class BeagleScreenViewModel {

    // MARK: ScreenType

    let screenType: ScreenType

    public enum ScreenType {
        case remote(String)
        case declarative(Widget)
    }

    // MARK: State

    private(set) var state: State {
        didSet { didChangeState() }
    }

    public enum State {
        case loading
        case result(Result<Widget, RemoteConnectorError>)
    }

    // MARK: Dependencies

    var dependencies: Dependencies

    public typealias Dependencies =
        DependencyActionExecutor
        & DependencyRemoteConnector
        & ViewRenderer.Dependencies

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
        case .declarative(let widget):
            state = .result(.success(widget))
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
            self.state = .result(result)
        }
    }

    func handleError(_ error: RemoteConnectorError) {
        delegate?.beagleScreen(viewModel: self, didFailToLoadWithError: error)
    }

    private func didChangeState() {
        stateObserver?.didChangeState(state)

        guard case .result(.failure(let error)) = state else { return }

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
