//
//  Copyright © 27/09/19 Zup IT. All rights reserved.
//

public protocol NetworkClient {
    typealias Error = NetworkError
    typealias Result = BeagleUI.Result<Data, NetworkError>

    typealias RequestCompletion = (Result) -> Void

    @discardableResult
    func executeRequest(
        _ request: Request,
        completion: @escaping RequestCompletion
    ) -> RequestToken?
}

public struct NetworkError: Error {
    public let error: Error

    public init(error: Error) {
        self.error = error
    }
}

/// Token reference to cancel a request
public protocol RequestToken {
    func cancel()
}

public protocol DependencyNetworkClient {
    var networkClient: NetworkClient { get }
}
