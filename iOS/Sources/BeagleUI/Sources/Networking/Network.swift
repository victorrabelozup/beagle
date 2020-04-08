/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

public protocol Network {

    @discardableResult
    func fetchComponent(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        completion: @escaping (Result<ServerDrivenComponent, Request.Error>) -> Void
    ) -> RequestToken?

    @discardableResult
    func submitForm(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        data: Request.FormData,
        completion: @escaping (Result<Action, Request.Error>) -> Void
    ) -> RequestToken?

    @discardableResult
    func fetchImage(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        completion: @escaping (Result<Data, Request.Error>) -> Void
    ) -> RequestToken?
}

public protocol DependencyNetwork {
    var network: Network { get }
}

// MARK: - Default

public final class NetworkDefault: Network {
    
    // MARK: Dependencies

    public typealias Dependencies =
        DependencyComponentDecoding
        & DependencyNetworkClient

    let dependencies: Dependencies
    
    // MARK: Initialization
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: Public Methods

    @discardableResult
    public func fetchComponent(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        completion: @escaping (Result<ServerDrivenComponent, Request.Error>) -> Void
    ) -> RequestToken? {
        let request = Request(url: url, type: .fetchComponent, additionalData: additionalData)
        return dependencies.networkClient.executeRequest(request) { [weak self] result in
            guard let self = self else { return }

            let mapped = result
                .flatMapError { .failure(.networkError($0)) }
                .flatMap { self.handleComponent($0) }

            DispatchQueue.main.async { completion(mapped) }
        }
    }

    @discardableResult
    public func submitForm(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        data: Request.FormData,
        completion: @escaping (Result<Action, Request.Error>) -> Void
    ) -> RequestToken? {
        let request = Request(url: url, type: .submitForm(data), additionalData: additionalData)
        return dependencies.networkClient.executeRequest(request) { [weak self] result in
            guard let self = self else { return }

            let mapped = result
                .flatMapError { .failure(.networkError($0)) }
                .flatMap { self.handleForm($0) }

            DispatchQueue.main.async { completion(mapped) }
        }
    }

    @discardableResult
    public func fetchImage(
        url: String,
        additionalData: RemoteScreenAdditionalData?,
        completion: @escaping (Result<Data, Request.Error>) -> Void
    ) -> RequestToken? {
        let request = Request(url: url, type: .fetchImage, additionalData: additionalData)
        return dependencies.networkClient.executeRequest(request) { result in
            let mapped = result
                .flatMapError { .failure(Request.Error.networkError($0)) }

            DispatchQueue.main.async { completion(mapped) }
        }
    }
    
    // MARK: Network Result Handlers
    
    private func handleComponent(
        _ data: Data
    ) -> Result<ServerDrivenComponent, Request.Error> {
        do {
            let component: ServerDrivenComponent = try dependencies.decoder.decodeComponent(from: data)
            return .success(component)
        } catch {
            return .failure(.decoding(error))
        }
    }
    
    private func handleForm(
        _ data: Data
    ) -> Result<Action, Request.Error> {
        do {
            let action: Action = try dependencies.decoder.decodeAction(from: data)
            return .success(action)
        } catch {
            return .failure(.decoding(error))
        }
    }
}
