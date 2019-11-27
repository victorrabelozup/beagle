//
//  ServerDrivenWidgetFetcher.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import Networking

public enum ServerDrivenWidgetFetcherError: Error {
    case request(URLRequestError)
    case emptyData
    case invalidEntity
    case decoding(Error)
    case mapping(Error)
    case unconvertibleEntity(WidgetEntity)
}

public protocol ServerDrivenWidgetFetcher {
    func fetchWidget(from url: URL, completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void)
    func submitForm(action: URL, method: Form.MethodType, values: [String: String], completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void)
}

public final class ServerDrivenWidgetFetching: ServerDrivenWidgetFetcher {
    
    // MARK: - Dependencies
    
    private let networkingDispatcher: URLRequestDispatching
    private let decoder: WidgetDecoding
    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(
            networkingDispatcher: Beagle.environment.shared.networkingDispatcher,
            decoder: Beagle.environment.shared.decoder
        )
    }
    
    init(
        networkingDispatcher: URLRequestDispatching,
        decoder: WidgetDecoding
    ) {
        self.networkingDispatcher = networkingDispatcher
        self.decoder = decoder
    }
    
    // MARK: - Public Methods
    
    public func fetchWidget(
        from url: URL,
        completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        let request = SimpleURLRequest(url: url)
        networkingDispatcher.execute(request: request) { [weak self] networkResult in
            switch networkResult {
            case let .success(data):
                self?.handleSuccess(data, completion: completion)
            case let .failure(error):
                completion(.failure(.request(error)))
            }
        }
    }
    
    public func submitForm(
        action: URL,
        method: Form.MethodType,
        values: [String: String],
        completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        let httpMethod: HTTPMethod
        switch method {
        case .get:
            httpMethod = .get
        case .post:
            httpMethod = .post
        case .put:
            httpMethod = .put
        case .delete:
            httpMethod = .delete
        }
        var request = SimpleURLRequest(url: action, method: httpMethod)
        switch httpMethod {
        case .get, .delete:
            request.parameters = .url(values)
        case .post, .put, .patch:
            request.parameters = .body(values)
        }
        networkingDispatcher.execute(request: request) { [weak self] networkResult in
            switch networkResult {
            case let .success(data):
                self?.handleFormSucess(data, completion: completion)
            case let .failure(error):
                completion(.failure(.request(error)))
            }
        }
    }
    
    // MARK: - Network Result Handlers
    
    private func handleSuccess(
        _ data: Data?,
        completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        
        guard let data = data else {
            completion(.failure(.emptyData))
            return
        }
        
        decode(data, completion: completion)
        
    }
    
    private func handleFormSucess(
        _ data: Data?,
        completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        guard let data = data else {
            completion(.failure(.emptyData))
            return
        }
        do {
            let action: Action = try decoder.decode(from: data)
            completion(.success(action))
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
    
    private func decode(
        _ data: Data,
        completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        do {
            let widget: Widget = try decoder.decode(from: data)
            completion(.success(widget))
            
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
}
