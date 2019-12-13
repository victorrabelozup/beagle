//
//  NetworkImageService.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 01/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

// MARK: - Fetching Image Helpers
protocol ImageDataProvider: NetworkingService {
    func fetchImageData(from urlString: String, completion: @escaping (Result<Data, ImageDataProviderError>) -> Void) -> URLRequestToken?
}

enum ImageDataProviderError: Error {
    case request(URLRequestError)
    case cache(CacheServiceError)
    case emptyData
}

final class ImageDataProviding: ImageDataProvider {
    
    // MARK: - Dependencies
    public var dispatcher: URLRequestDispatching
    private let cacheService: CacheServiceProvider
    
    init(
        dispatcher: URLRequestDispatching = Beagle.networkingDispatcher,
        cacheService: CacheServiceProvider = MemoryCacheService()
    ) {
        self.dispatcher = dispatcher
        self.cacheService = cacheService
    }
    
    func fetchImageData(from urlString: String, completion: @escaping (Result<Data, ImageDataProviderError>) -> Void) -> URLRequestToken? {
        var urlRequestToken: URLRequestToken?
        
        cacheService.loadData(from: urlString) { [weak self] cacheResult in
            if let cachedData = try? cacheResult.get() {
                completion(.success(cachedData))
            } else {
                urlRequestToken = self?.requestImage(from: urlString, completion: completion)
            }
        }
        return urlRequestToken
    }
    
    // MARK: - Private Functions
    
    private func requestImage(from urlString: String, completion: @escaping (Result<Data, ImageDataProviderError>) -> Void) -> URLRequestToken? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.request(.requestBuilderFailed)))
            return nil
        }
        let request = SimpleURLRequest(url: url)
        return dispatcher.execute(request: request) { [weak self] networkResult in
            switch networkResult {
            case let .success(data):
                self?.handleSuccess(urlString: urlString, data: data, completion: completion)
            case let .failure(error):
                completion(.failure(.request(error)))
            }
        }
    }
    
    private func handleSuccess(urlString: String, data: Data?, completion: @escaping (Result<Data, ImageDataProviderError>) -> Void) {
        guard let data = data else {
            completion(.failure(.emptyData))
            return
        }
        cacheService.save(data: data, key: urlString, completion: nil)
        completion(.success(data))
    }
    
}
