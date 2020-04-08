/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
