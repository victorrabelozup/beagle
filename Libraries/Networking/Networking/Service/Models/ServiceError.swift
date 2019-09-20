//
//  ServiceError.swift
//  Networking
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Bocato. All rights reserved.
//

import Foundation

import Foundation

private let domain = "ServiceError"

// MARK: - Service Errors

public enum ServiceError: Error {
    
    case unknown
    case unexpected
    case api(URLRequestError)
    case serializationError(Error)
    case noData
    case invalidURL
    
    public var code: Int {
        switch self {
        case .unknown:
            return 10
        case .unexpected:
            return 11
        case .api(let requestError):
            return requestError.code
        case .serializationError:
            return 12
        case .noData:
            return 13
        case .invalidURL:
            return 14
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .unknown:
            return "An unknown error has occurred in the service."
        case .unexpected:
            return "An unexpected error has occurred in the service."
        case .api:
            return "There was an error in the API."
        case .serializationError:
            return "A serialization error has occurred."
        case .noData:
            return "No data was found."
        case .invalidURL:
            return "The URL is invalid."
        }
    }
    
    public var rawError: NSError {
        switch self {
        case .api(let apiError):
            return apiError.rawError
        case .serializationError(let error):
            return error as NSError
        default:
            return NSError(domain: domain, code: code, description: localizedDescription)
        }
    }
    
}
