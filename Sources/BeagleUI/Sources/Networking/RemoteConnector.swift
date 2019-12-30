//
//  Copyright © 17/10/19 Zup. All rights reserved.
//

import Foundation

public enum RemoteConnectorError: Error {
    case invalidURL
    case request(URLRequestError)
    case emptyData
    case invalidEntity
    case decoding(Error)
    case mapping(Error)
    case unconvertibleEntity(WidgetEntity)
}

public protocol RemoteConnector {
    typealias Error = RemoteConnectorError
    typealias WidgetCompletion = (Result<Widget, Error>) -> Void
    typealias FormCompletion = (Result<Action, Error>) -> Void

    func fetchWidget(
        from url: String,
        completion: @escaping WidgetCompletion
    )

    func submitForm(
        action: String,
        method: Form.MethodType,
        values: [String: String],
        completion: @escaping FormCompletion
    )
}

public protocol DependencyRemoteConnector {
    var remoteConnector: RemoteConnector { get }
}

public protocol DependencyBaseURL {
    var baseURL: URL? { get }
}

public final class RemoteConnecting: RemoteConnector {
    
    // MARK: - Dependencies

    public typealias Dependencies =
        DependencyBaseURL
        & DependencyWidgetDecoding
        & DependencyNetworkDispatcher

    let dependencies: Dependencies
    
    // MARK: - Initialization
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    
    public func fetchWidget(
        from url: String,
        completion: @escaping WidgetCompletion
    ) {
        guard let requestURL = fullRequestURL(url) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = SimpleURLRequest(url: requestURL)
        dependencies.networkDispatcher.execute(request: request) { [weak self] networkResult in
            switch networkResult {
            case let .success(data):
                self?.handleSuccess(data, completion: completion)
            case let .failure(error):
                completion(.failure(.request(error)))
            }
        }
    }
    
    public func submitForm(
        action: String,
        method: Form.MethodType,
        values: [String: String],
        completion: @escaping FormCompletion
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
        guard let requestURL = fullRequestURL(action) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = SimpleURLRequest(url: requestURL, method: httpMethod)
        switch httpMethod {
        case .get, .delete:
            request.parameters = .url(values)
        case .post, .put, .patch:
            request.parameters = .body(values)
        }
        request.headers = ["Content-Type": "application/json"]
        dependencies.networkDispatcher.execute(request: request) { [weak self] in
            switch $0 {
            case let .success(data):
                self?.handleFormSucess(data, completion: completion)
            case let .failure(error):
                completion(.failure(.request(error)))
            }
        }
    }
    
    private func fullRequestURL(_ url: String) -> URL? {
        return URL(string: url, relativeTo: dependencies.baseURL)
    }
    
    // MARK: - Network Result Handlers
    
    private func handleSuccess(
        _ data: Data?,
        completion: @escaping WidgetCompletion
    ) {
        
        guard let data = data else {
            completion(.failure(.emptyData))
            return
        }
        
        decode(data, completion: completion)
        
    }
    
    private func handleFormSucess(
        _ data: Data?,
        completion: @escaping FormCompletion
    ) {
        guard let data = data else {
            completion(.failure(.emptyData))
            return
        }
        do {
            let action: Action = try dependencies.decoder.decodeAction(from: data)
            completion(.success(action))
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
    
    private func decode(
        _ data: Data,
        completion: @escaping WidgetCompletion
    ) {
        do {
            let widget: Widget = try dependencies.decoder.decodeWidget(from: data)
            completion(.success(widget))
            
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
}
