//
//  Copyright © 05/02/20 Zup IT. All rights reserved.
//

import Foundation

public class NetworkClientDefault: NetworkClient {

    typealias Dependencies = DependencyBaseURL

    let session = URLSession.shared
    let dependencies: Dependencies

    private let urlBuilder = UrlRequestBuilder()
    private let cacheService = MemoryCacheService()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    enum ClientError: Swift.Error {
        case invalidHttpResponse
        case invalidUrl
    }

    public func executeRequest(
        _ request: Request,
        completion: @escaping RequestCompletion
    ) -> RequestToken? {
        switch request.type {
        case .fetchComponent, .submitForm:
            return doRequest(request, completion: completion)
        case .fetchImage:
            break
        }

        if let cache = try? cacheService.loadData(from: request.url).get() {
            completion(.success(cache))
            return nil
        } else {
            return doRequest(request, completion: completion)
        }
    }

    @discardableResult
    public func doRequest(
        _ request: Request,
        completion: @escaping RequestCompletion
    ) -> RequestToken? {
        switch urlBuilder.buildUrlRequest(request: request, baseUrl: dependencies.baseURL) {
        case .failure(let error):
            completion(.failure(.init(error: error)))
            return nil

        case .success(let url):
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                self.saveDataToCacheIfNeeded(data: data, request: request)
                completion(self.handleResponse(data: data, response: response, error: error))
            }

            task.resume()
            return task
        }
    }

    private func handleResponse(
        data: Data?,
        response: URLResponse?,
        error: Swift.Error?
    ) -> NetworkClient.Result {
        if let error = error {
            return .failure(.init(error: error))
        }

        guard
            let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode),
            let data = data
        else {
            return .failure(NetworkError(error: ClientError.invalidHttpResponse))
        }

        return .success(data)
    }

    private func saveDataToCacheIfNeeded(data: Data?, request: Request) {
        guard case .fetchImage = request.type, let data = data else { return }
        cacheService.save(data: data, key: request.url)
    }
}

extension URLSessionDataTask: RequestToken { }
