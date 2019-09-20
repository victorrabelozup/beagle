//
//  SerializableService.swift
//  Networking
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Bocato. All rights reserved.
//

import Foundation

public protocol CodableSerializing {
    
    /// Helper function to serialize results when needed.
    ///
    /// - Parameters:
    ///   - result: The result from the dispatcher.
    ///   - responseType: The response type (Codable).
    ///   - completion: The serialization completion handler.
    func serializeCodable<ResponseType: Codable>(
        _ result: Result<Data?, URLRequestError>,
        responseType: ResponseType.Type,
        completion: @escaping (Result<ResponseType, ServiceError>) -> Void)
}
extension CodableSerializing {
    
    public func serializeCodable<ResponseType: Codable>(
        _ result: Result<Data?, URLRequestError>,
        responseType: ResponseType.Type,
        completion: @escaping (Result<ResponseType, ServiceError>) -> Void
    ) {
        
        switch result {
        case let .success(data):
            handleSuccess(
                data: data,
                responseType: ResponseType.self,
                completion: completion)
        case let .failure(error):
            completion(.failure(.api(error)))
        }
        
    }
    
    private func handleSuccess<ResponseType: Codable>(
        data: Data?,
        responseType: ResponseType.Type,
        completion: @escaping (Result<ResponseType, ServiceError>) -> Void
    ) {
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        do {
            let serializedResponse = try JSONDecoder().decode(responseType.self, from: data)
            completion(.success(serializedResponse))
        } catch {
            debugPrint(error)
            completion(.failure(.serializationError(error)))
        }
    }
    
}

