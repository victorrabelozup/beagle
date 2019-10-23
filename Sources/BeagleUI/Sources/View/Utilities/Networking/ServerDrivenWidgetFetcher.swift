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
    
    private func decode(
        _ data: Data,
        completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        do {
            
            guard let entity = try decoder.decode(from: data) else {
                completion(.failure(.invalidEntity))
                return
            }
            
            mapEntityToWidget(entity, completion: completion)
            
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
    
    private func mapEntityToWidget(
        _ entity: WidgetEntity,
        completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void
    ) {
        
        guard let convertibleEntity = entity as? WidgetConvertible else {
            completion(.failure(.unconvertibleEntity(entity)))
            return
        }
        
        do {
            let widget = try convertibleEntity.mapToWidget()
            completion(.success(widget))
        } catch {
            completion(.failure(.mapping(error)))
        }
        
    }
    
}
